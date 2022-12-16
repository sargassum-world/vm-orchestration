# GCP source

gcp_project_id = "soe-sargassum-planktoscope"
gcp_service_account = "infra-packer@soe-sargassum-planktoscope.iam.gserviceaccount.com"
gcp_zone = "us-west1-a"
gcp_network = "foundations"
gcp_subnetwork = "foundations-us-west1"

# Hashistack provisioning

hashistack_nomad_datacenter = "sargassum-foundations"
hashistack_expected_cluster_size = 1
hashistack_nomad_join_server = "nomad.d.foundations.infra.sargassum.world"
