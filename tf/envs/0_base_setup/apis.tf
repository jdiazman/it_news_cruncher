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