#!/bin/bash -eux

sudo systemctl stop docker
sudo rm -rf /var/lib/docker/volumes
sudo ln -s $DATA_MOUNT /var/lib/docker/volumes
