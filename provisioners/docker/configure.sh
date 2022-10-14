#!/bin/bash -eux

sudo systemctl stop docker
sudo ln -s /mnt/disks/data /var/lib/docker/volumes
