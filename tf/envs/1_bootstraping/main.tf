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