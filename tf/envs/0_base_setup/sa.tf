resource "google_service_account" "cloudbuild" {
    account_id   = "cloudbuild-sa"
    project = local.envs.PROJECT_ID
    display_name = "Cloud Build Service Account"
    description  = "Service account for Cloud Build jobs"
}

resource "google_service_account" "deployments" {
    account_id   = "deployments-sa"
    project = local.envs.PROJECT_ID
    display_name = "Deployments Service Account"
    description  = "Service account for deployment operations"
}

resource "google_project_iam_member" "cloudbuild_role" {
    project = local.envs.PROJECT_ID
    role    = "roles/cloudbuild.builds.builder"
    member  = "serviceAccount:${google_service_account.cloudbuild.email}"
}