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

NFS_PATH="/srv/nfs/k3s"

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
mkdir -p $NFS_PATH
echo "NFS StorageClass To Container" | sudo tee $NFS_PATH/index.html
echo "$NFS_PATH *(rw,sync,no_subtree_check,no_root_squash)" | sudo tee -a /etc/exports
}

function check_nfs_export() {
    if showmount -e localhost | grep -q "$NFS_PATH"; then
        echo "NFS export $NFS_PATH exists."
        return 0
    else
        echo "NFS export $NFS_PATH not found."
        return 1
    fi	
}


