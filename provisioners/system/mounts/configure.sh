#!/bin/bash -eux

sudo cp /tmp/packer-files/system/mounts/fstab /etc/fstab

sudo mkdir -p /mnt/disks/data
sudo chmod 701 /mnt/disks/data # match chmod flags for /var/lib/docker
