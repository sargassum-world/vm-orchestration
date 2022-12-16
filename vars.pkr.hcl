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

variable "gcp_network" {
  type = string
  description = "GCP network for the builder VM"
}

variable "gcp_subnetwork" {
  type = string
  description = "GCP subnetwork for the builder VM"
}

# Disk mount provisioning

variable "system_mounts_data_device" {
  type = string
  description = "Device path of data disk for persisting Docker volumes"
  default = "/dev/disk/by-id/google-data"
}

variable "system_mounts_data_mount" {
  type = string
  description = "Mount path of data disk for persisting Docker volumes"
  default = "/mnt/disks/data"
}

# Hashistack provisioning

variable "hashistack_nomad_datacenter" {
  type = string
  description = "Identifier for the datacenter in which the Hashistack agent runs"
}

variable "hashistack_expected_cluster_size" {
  type = number
  description = "Number of expected servers in the cluster for bootstrapping"
}

variable "hashistack_nomad_bootstrap_token" {
  type = string
  description = "Secret ID for ACL bootstrap token"
  sensitive = true
}

variable "hashistack_nomad_role" {
  type = string
  description = "Orchestration role (either orchestrator or worker)"
}

variable "hashistack_nomad_server_tag" {
  type = string
  description = "Server tag for auto-joining a Nomad server"
  default = "nomad-server"
}
