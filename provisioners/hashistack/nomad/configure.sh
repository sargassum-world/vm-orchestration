#!/bin/bash -eux

# Copy configuration files
sudo cp /tmp/packer-files/hashistack/nomad/*.hcl /etc/nomad.d/
sudo chmod 644 /etc/nomad.d/*.hcl
sudo chown nomad:nomad /etc/nomad.d/*.hcl

# Set up systemd service
sudo systemctl enable nomad.service
sudo systemctl start nomad.service
sleep 1

# Bootstrap ACLs
until nomad acl bootstrap /tmp/packer-files/hashistack/nomad/root.token >> /dev/null; do
  sleep 1
done
