# Ensures the Cloud Build API is enabled.
resource "google_project_service" "cloudbuildapi" {
  project = var.project
  service = "cloudbuild.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

resource "google_cloudbuild_trigger" "filename-trigger" {
  name     = "github"
  filename = "cloudbuild.yaml"

  github {
    owner = var.github_owner
    name  = "tfsec-dummy-project"
    push {
      branch = "^build$"
    }
  }

  depends_on = [google_project_service.cloudbuildapi]
}
