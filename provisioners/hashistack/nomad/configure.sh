#!/bin/bash -eux

# Copy configuration files
sudo cp /tmp/packer-files/hashistack/nomad/*.hcl /etc/nomad.d/
sudo chmod 644 /etc/nomad.d/*.hcl
sudo chown nomad:nomad /etc/nomad.d/*.hcl

# Set up systemd
sudo systemctl enable nomad.service

# Bootstrap ACLs
nomad acl bootstrap /tmp/packer-files/hashistack/nomad/root.token >> /dev/null
