#!/usr/bin/env bash

set -euo pipefail

# Menu: Devices > Insert Guest Additions CD
sudo apt install build-essential dkms "linux-headers-$(uname -r)"

sudo mount /dev/cdrom /mnt
sudo /mnt/VBoxLinuxAdditions-arm64.run
