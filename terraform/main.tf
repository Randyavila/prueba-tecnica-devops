#Provider
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# Artifact Registry Repository Helm Charts
resource "google_artifact_registry_repository" "helm_repo" {
  name         = "helm-charts"
  repository_id = "helm-charts"
  format       = "DOCKER"
  location     = var.region
}

resource "google_artifact_registry_repository_iam_member" "admin" {
  repository = google_artifact_registry_repository.helm_repo.name
  role       = "roles/artifactregistry.admin"
  member     = "serviceAccount:${var.service_account_email}"
}

# Copiar Helm Chart desde Reference Registry a Instance Registry
resource "null_resource" "helm_chart_sync" {
  provisioner "local-exec" {
    command = <<EOT
      helm repo add source-repo ${var.reference_registry}
      helm repo add dest-repo ${google_artifact_registry_repository.helm_repo.url}
      helm pull source-repo/${var.chart_name} --version ${var.chart_version}
      helm push ${var.chart_name}-${var.chart_version}.tgz dest-repo
    EOT
  }

  triggers = {
    chart_name    = var.chart_name
    chart_version = var.chart_version
  }
}

# Helm Deployment Module
module "helm_chart" {
  source                  = "./modules/helm_chart"
  helm_repo_url           = google_artifact_registry_repository.helm_repo.url
  chart_name              = var.chart_name
  chart_version           = var.chart_version
  dependency_service_name = var.dependency_service_name
  gke_cluster_name        = var.gke_cluster_name
  region                  = var.region
  zone                    = var.zone
}
