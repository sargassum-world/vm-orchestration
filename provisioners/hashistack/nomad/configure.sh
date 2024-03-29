#!/bin/bash -eux

# Copy configuration files
sudo cp /tmp/packer-files/hashistack/nomad/nomad.hcl /etc/nomad.d/nomad.hcl
sudo cp /tmp/packer-files/hashistack/nomad/client.hcl /etc/nomad.d/client.hcl
if [[ "$ROLE" == "orchestrator" ]]; then
  sudo cp /tmp/packer-files/hashistack/nomad/orchestrator-server.hcl /etc/nomad.d/server.hcl
  sudo cp /tmp/packer-files/hashistack/nomad/orchestrator-client.hcl /etc/nomad.d/client-orchestrator.hcl
elif [[ "$ROLE" == "worker" ]]; then
  sudo cp /tmp/packer-files/hashistack/nomad/worker-client.hcl /etc/nomad.d/client-worker.hcl
fi
sudo chmod 644 /etc/nomad.d/*.hcl
sudo chown nomad:nomad /etc/nomad.d/*.hcl

# Set up systemd service
sudo systemctl enable nomad.service
sudo systemctl start nomad.service
sleep 1

# Bootstrap ACLs
if [[ "$ROLE" == "orchestrator" ]]; then
  until nomad acl bootstrap /tmp/packer-files/hashistack/nomad/root.token >> /dev/null; do
    sleep 1
  done
fi
