
# Cloud Run Service
resource "google_cloud_run_service" "news_agent" {
  name     = "it-news-cruncher"
  location = var.region

  template {
    spec {
      containers {
        image = "europe-west1-docker.pkg.dev/${var.project_id}/it-news-cruncher-repo/it-news-cruncher:latest"

        ports {
          container_port = 8080
        }

        env {
          name  = "OPENAI_API_KEY"
          value = var.openai_api_key
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# TODO: Invoking only insiders project for testing
resource "google_cloud_run_service_iam_member" "invoker" {
  location = google_cloud_run_service.news_agent.location
  project  = var.project_id
  service  = google_cloud_run_service.news_agent.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}


resource "google_pubsub_topic" "news_trigger" {
  name = "news-trigger"
}

resource "google_cloud_scheduler_job" "daily_job" {
  name        = "daily-news"
  schedule    = "0 9 * * *" # 09:00 CET
  time_zone   = "Europe/Madrid"
  pubsub_target {
    topic_name = google_pubsub_topic.news_trigger.id
    data       = base64encode("{}")
  }
}