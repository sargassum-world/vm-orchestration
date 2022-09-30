source "googlecompute" "foundations-orchestrator" {
  project_id = "sargassum-world"
  source_image_project_id = ["ubuntu-os-cloud"]
  source_image_family = "ubuntu-minimal-2204-lts"
  zone = "us-west1-a"

  service_account_email = "infra-packer@sargassum-world.iam.gserviceaccount.com"

  image_name = "foundations-orchestrator-{{timestamp}}"
  image_description = "Sargassum, Ubuntu, 22.04 LTS Minimal, amd64 jammy minimal image, supports Shielded VM features, with Docker and HashiStack"
  image_family = "sargassum-orchestrator-2204"

  disk_size = 10
  disk_type = "pd-standard"
  enable_vtpm = true
  enable_integrity_monitoring = true

  network = "default"

  // Note: the GCP IAP API must be enabled; the gcloud sdk must be installed on the computer running
  // Packer; and the account running Packer must have the "IAP-secured Tunnel User" role
  /*omit_external_ip = true
  use_internal_ip = true
  subnetwork = "foundations-us-west1"
  use_iap = true*/

  ssh_username = "packer"
}

build {
  sources = ["sources.googlecompute.foundations-orchestrator"]

  provisioner "shell" {
    scripts = [
      "./provisioners/scripts/upgrade.sh",
      "./provisioners/scripts/install-podman.sh",
      "./provisioners/scripts/install-hashistack.sh"
    ]
  }

  post-processor "manifest" {
    output      = "packer_manifest.json"
    strip_path  = true
    custom_data = {
      iteration_id = packer.iterationID
    }
  }
}
