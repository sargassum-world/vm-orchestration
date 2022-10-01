# GCP source

variable "gcp_project_id" {
  type = string
  description = "GCP project ID"
}

variable "gcp_service_account" {
  type = string
  description = "GCP service account email address"
}

variable "gcp_zone" {
  type = string
  description = "GCP build zone"
}

# Hashistack provisioning

variable "hashistack_datacenter" {
  type = string
  description = "Identifier for the datacenter in which the Hashistack agent runs"
}

variable "hashistack_expected_cluster_size" {
  type = number
  description = "Number of expected servers in the cluster for bootstrapping"
}
