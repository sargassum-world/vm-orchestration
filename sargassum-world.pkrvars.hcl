# GCP source

gcp_project_id = "sargassum-world"
gcp_service_account = "infra-packer@sargassum-world.iam.gserviceaccount.com"
gcp_zone = "us-west1-a"
gcp_network = "foundations"
gcp_subnetwork = "foundations-us-west1"

# Disk mount provisioning

system_mounts_data_device = "/dev/disk/by-id/google-data"
system_mounts_data_mount = "/mnt/disks/data"

# Hashistack provisioning

hashistack_nomad_datacenter = "sargassum-foundations"
hashistack_expected_cluster_size = 1
