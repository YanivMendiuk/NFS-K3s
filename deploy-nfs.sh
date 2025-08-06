#!/usr/bin/env bash
# -----------------------------------------------------
# Script Name:    deploy-nfs.sh
# Version:        1.1.0
# Author:         Yaniv Mendiuk
# Date:           2025-03-15
# Description:
# This script automates the installation of NFS package and create an NFS shared directory.

set -o errexit
set -o pipefail
# -----------------------------------------------------

function check_no_root() {
    if [[ $EUID -eq 0 ]] || [[ $UID -eq 0 ]]; then
        echo "Error: Do not use root user or sudo to run this script"
        exit 1
    else
        # Check if we can use sudo
        if ! command -v sudo &> /dev/null; then
            echo "Error: sudo is required but not installed"
            exit 1
        fi
        sudo -v
    fi
}

# Checking which OS
whichOS=$(cat /etc/os-release | grep "ID_LIKE=" | sed 's/ID_LIKE=//')
echo "Detected OS: $whichOS"

# Install NFS Kernel and Setup of NFS Server
install_setup_nfs() { 
sudo dnf update && sudo dnf install nfs-utils
sudo systemctl enable --now nfs-server rpcbind
mkdir -p /srv/nfs/k3s
echo "NFS StorageClass To Container" | sudo tee /srv/nfs/k3s/index.html
echo "/srv/nfs/k3s *(rw,sync,no_subtree_check,no_root_squash)" | sudo tee -a /etc/exports
}

function check_nfs_server() {
	
}


