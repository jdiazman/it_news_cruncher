terraform {
    required_version = ">= 1.11.0"
    required_providers {
        google = {
            source  = "hashicorp/google"
            version = ">= 4.0.0"
        }
    }
}

provider "google" {
    project = local.envs.PROJECT_ID
    region  = local.envs.REGION
    zone    = local.envs.ZONE
}

module "compute_instances" {
    source = "../../modules/compute_instances"

    project_id = local.envs.PROJECT_ID
    region     = local.envs.REGION
    zone       = local.envs.ZONE
}

resource "google_pubsub_topic" "news_trigger" {
  name = "news-trigger"
}

resource "google_cloud_run_service" "news_agent" {
  name     = "news-agent"
  location = "europe-west1"
  template {
    spec {
      containers {
        image = "gcr.io/${local.envs.PROJECT_ID}/news-agent:latest"
        env {
          name  = "OPENAI_API_KEY"
          value = local.envs.OPENAI_API_KEY
        }
      }
    }
  }
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