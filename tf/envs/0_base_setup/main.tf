terraform {
  required_providers {//todo: align versions and check for down limits
    google = {
      source = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

resource "google_project_iam_member" "editor" {
    project = local.envs.PROJECT_ID
    role    = "roles/editor"
    member  = "user:${local.envs.MAIL}"
}

# Artifact Registry (to store the container)
resource "google_artifact_registry_repository" "it_news_news_cruncher_repo" {
  project = local.envs.PROJECT_ID
  location      = local.envs.REGION
  repository_id = "it-news-cruncher-repo"
  format        = "DOCKER"

  depends_on = [ google_project_service.artifacts_api ]
}