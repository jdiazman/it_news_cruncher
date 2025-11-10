resource "google_project_service" "compute_api" {
  project = local.envs.PROJECT_ID
  service = "compute.googleapis.com" 
  disable_dependent_services = true
}

resource "google_project_service" "storage_api" {
  project = local.envs.PROJECT_ID
  service = "storage.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "artifacts_api" {
  project = local.envs.PROJECT_ID
  service = "artifactregistry.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "cloud_run_api" {
  project = local.envs.PROJECT_ID
  service = "run.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "pubsub_api" {
  project = local.envs.PROJECT_ID
  service = "pubsub.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "cloud_scheduler_api" {
  project = local.envs.PROJECT_ID
  service = "cloudscheduler.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "cloubduild_api" {
  project = local.envs.PROJECT_ID
  service = "cloudbuild.googleapis.com"
  disable_dependent_services = true
}