# Note: the Packer service account must be given the Compute Instance Admin role, so that it can
# create and destroy Google Compute Engine resources (VMs, images, etc.). You can manually do this
# from the IAM & Admin console. It must also be given the IAP-secured Tunnel User role, so that it
# can ssh into the builder VM for provisioning.
source "googlecompute" "ubuntu-minimal" {
  source_image_project_id = ["ubuntu-os-cloud"]
  source_image_family = "ubuntu-minimal-2204-lts"

  disk_type = "pd-standard"
  enable_vtpm = true
  enable_integrity_monitoring = true

  ssh_username = "packer"
  tags = ["iap-ssh"]
  use_iap = true
}

build {
  name = "sargassum-foundations-${var.hashistack_nomad_role}"

  source "googlecompute.ubuntu-minimal" {
    project_id = var.gcp_project_id
    zone = var.gcp_zone
    network = var.gcp_network
    subnetwork = var.gcp_subnetwork
    service_account_email = var.gcp_service_account

    image_name = "sargassum-foundations-${var.hashistack_nomad_role}-{{timestamp}}"
    image_description = "Sargassum, Ubuntu, 22.04 LTS Minimal, amd64 jammy minimal image, supports Shielded VM features, with HashiStack"
    image_family = "sargassum-foundations-${var.hashistack_nomad_role}"

    disk_size = 10
  }

  # System provisioning

  provisioner "shell" {
    scripts = [
      "./provisioners/system/upgrade.sh",
      "./provisioners/system/install.sh",
      "./provisioners/system/mounts/preconfigure.sh",
    ]
  }

  provisioner "shell" {
    script = "./provisioners/system/sysctl/preconfigure.sh"
  }

  provisioner "file" {
    sources = [
      "./provisioners/system/sysctl/99-quic-udp.conf",
    ]
    destination = "/tmp/packer-files/system/sysctl/"
  }

  provisioner "shell" {
    script = "./provisioners/system/sysctl/configure.sh"
  }

  provisioner "file" {
    content = templatefile("./provisioners/system/mounts/fstab.pkrtpl", {
      data_device = var.system_mounts_data_device
      data_mount = var.system_mounts_data_mount
    })
    destination = "/tmp/packer-files/system/mounts/fstab"
  }

  provisioner "shell" {
    script = "./provisioners/system/mounts/configure.sh"
    env = {
      DATA_MOUNT = var.system_mounts_data_mount
    }
  }

  # Docker provisioning

  provisioner "shell" {
    scripts = [
      "./provisioners/docker/add-repository.sh",
      "./provisioners/docker/install.sh",
      "./provisioners/docker/configure.sh",
    ]
    env = {
      DATA_MOUNT = var.system_mounts_data_mount
    }
  }

  # Zerotier provisioning

  provisioner "shell" {
    scripts = [
      "./provisioners/zerotier/install.sh",
      "./provisioners/zerotier/configure.sh",
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
      datacenter = var.hashistack_nomad_datacenter
    })
    destination = "/tmp/packer-files/hashistack/nomad/nomad.hcl"
  }

  provisioner "file" {
    sources = [
      "./provisioners/hashistack/nomad/client.hcl",
    ]
    destination = "/tmp/packer-files/hashistack/nomad/"
  }

  provisioner "file" {
    content = templatefile("./provisioners/hashistack/nomad/orchestrator-server.hcl.pkrtpl", {
      expected_cluster_size = var.hashistack_expected_cluster_size
    })
    destination = "/tmp/packer-files/hashistack/nomad/orchestrator-server.hcl"
  }

  provisioner "file" {
    content = templatefile("./provisioners/hashistack/nomad/orchestrator-client.hcl.pkrtpl", {})
    destination = "/tmp/packer-files/hashistack/nomad/orchestrator-client.hcl"
  }

  provisioner "file" {
    content = templatefile("./provisioners/hashistack/nomad/worker-client.hcl.pkrtpl", {
      nomad_join_server = var.hashistack_nomad_join_server
    })
    destination = "/tmp/packer-files/hashistack/nomad/worker-client.hcl"
  }

  provisioner "file" {
    content = var.hashistack_nomad_bootstrap_token
    destination = "/tmp/packer-files/hashistack/nomad/root.token"
  }

  provisioner "shell" {
    script = "./provisioners/hashistack/nomad/configure.sh"
    env = {
      ROLE = var.hashistack_nomad_role
    }
  }
}
