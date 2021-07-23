terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials)

  project = var.project_id
  region  = "asia-northeast1"
  zone    = "asia-northeast1-c"
}

resource "google_project_iam_member" "this" {
  project = var.project_id
  role    = "roles/appengine.appAdmin"
  member  = "serviceAccount:${var.project_number}@cloudbuild.gserviceaccount.com"
}

resource "google_project_iam_member" "service_account_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${var.project_number}@cloudbuild.gserviceaccount.com"
}

resource "google_app_engine_application" "app" {
  project     = var.project_id
  location_id = "asia-northeast1"
}

resource "google_cloudbuild_trigger" "this" {
  project = var.project_id
  trigger_template {
    branch_name = var.branch_name
    repo_name   = "wiki-quiz-backend"
  }
  filename = "cloudbuild.yaml"
}
