terraform {
  required_providers {//todo: align versions and check for down limits
    google = {
      source = "hashicorp/google"
      version = "6.8.0"
    }
  }
}


provider "google" {
    project = local.envs.PROJECT_ID
    region  = local.envs.REGION
    zone    = local.envs.ZONE
}

module "it_news_cruncher_service" {
    source = "../../modules/service"

    project_id = local.envs.PROJECT_ID
    region     = local.envs.REGION
    openai_api_key = local.envs.OPENAI_API_KEY
}
