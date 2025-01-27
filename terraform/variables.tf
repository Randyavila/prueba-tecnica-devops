variable "project_id" {
  description = "The ID of the Google Cloud project where the resources will be deployed."
  type        = string
}

variable "region" {
  description = "The region where the resources will be deployed."
  type        = string
}

variable "zone" {
  description = "The zone where the GKE cluster is located."
  type        = string
}

variable "reference_registry" {
  description = "The URL of the reference GCP Artifact Registry where the Helm charts are stored."
  type        = string
}

variable "instance_registry" {
  description = "The URL of the instance GCP Artifact Registry to copy the Helm charts."
  type        = string
}

variable "helm_repo_url" {
  description = "The URL of the Helm repository in the instance registry."
  type        = string
}

variable "chart_name" {
  description = "The name of the Helm chart to deploy."
  type        = string
}

variable "chart_version" {
  description = "The version of the Helm chart to deploy."
  type        = string
}

variable "dependency_service_name" {
  description = "The name of the dependency service that must be running before deploying the Helm chart."
  type        = string
}

variable "gke_cluster_name" {
  description = "The name of the GKE cluster where the Helm chart will be deployed."
  type        = string
}

variable "service_account_email" {
  description = "The email of the service account with the necessary permissions for managing Artifact Registry."
  type        = string
}
