#!/bin/bash -eux

sudo cp /tmp/packer-files/system/mounts/fstab /etc/fstab

sudo mkdir -p $DATA_MOUNT
sudo chmod 700 $DATA_MOUNT # match chmod flags for /var/lib/docker
