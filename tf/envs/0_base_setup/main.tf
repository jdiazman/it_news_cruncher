terraform {
  required_providers {
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

