source "googlecompute" "ubuntu-minimal" {
  source_image_project_id = ["ubuntu-os-cloud"]
  source_image_family = "ubuntu-minimal-2204-lts"

  disk_type = "pd-standard"
  enable_vtpm = true
  enable_integrity_monitoring = true

  network = "default"

  ssh_username = "packer"
}

build {
  name = "sargassum-foundations-orchestrator"

  source "googlecompute.ubuntu-minimal" {
    project_id = var.gcp_project_id
    zone = var.gcp_zone
    service_account_email = var.gcp_service_account

    image_name = "sargassum-foundations-orchestrator-{{timestamp}}"
    image_description = "Sargassum, Ubuntu, 22.04 LTS Minimal, amd64 jammy minimal image, supports Shielded VM features, with Podman and HashiStack"
    image_family = "sargassum-foundations-orchestrator"

    disk_size = 10
  }

  # System provisioning

  provisioner "shell" {
    script = "./provisioners/system/upgrade.sh"
  }

  # Containerd provisioning

  provisioner "shell" {
    scripts = [
      "./provisioners/containerd/add-repository.sh",
      "./provisioners/containerd/install.sh",
    ]
  }

  # Hashistack provisioning

  provisioner "shell" {
    script = "./provisioners/hashistack/add-repository.sh"
  }

  # Hashistack Nomad provisioning

  provisioner "shell" {
    script = "./provisioners/hashistack/nomad/install.sh"
  }

  provisioner "file" {
    content = templatefile("./provisioners/hashistack/nomad/nomad.hcl.pkrtpl", {
      datacenter = var.hashistack_datacenter
    })
    destination = "/tmp/packer-files/hashistack/nomad/nomad.hcl"
  }

  provisioner "file" {
    content = templatefile("./provisioners/hashistack/nomad/server.hcl.pkrtpl", {
      expected_cluster_size = var.hashistack_expected_cluster_size
    })
    destination = "/tmp/packer-files/hashistack/nomad/server.hcl"
  }

  provisioner "file" {
    content = templatefile("./provisioners/hashistack/nomad/client.hcl.pkrtpl", {})
    destination = "/tmp/packer-files/hashistack/nomad/client.hcl"
  }

  provisioner "shell" {
    script = "./provisioners/hashistack/nomad/configure.sh"
  }
}
