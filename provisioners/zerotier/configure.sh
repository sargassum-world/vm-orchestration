#!/bin/bash -eux

sudo systemctl stop zerotier-one
sudo systemctl disable zerotier-one
sudo rm /var/lib/zerotier-one/identity.public
sudo rm /var/lib/zerotier-one/identity.secret
sudo rm /var/lib/zerotier-one/authtoken.secret
