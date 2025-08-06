K3s NFS Application Deployment
This project provides a simple, automated solution for setting up an NFS server and deploying an Nginx application on a K3s (Lightweight Kubernetes) cluster that utilizes the NFS share for its persistent storage.

Project Structure
The project is organized as follows:

.
├── deploy-nfs.sh
├── manifests
│   ├── nfs-pvc.yaml
│   ├── nfs-pv.yaml
│   ├── nginx-configmap.yaml
│   ├── nginx-deployment.yaml
│   └── nginx-service.yaml
└── README.md
Features
Automated NFS Setup: Installs the necessary NFS utilities and configures an NFS export on the local machine.

K3s Resource Deployment: Deploys Kubernetes Persistent Volume (PV), Persistent Volume Claim (PVC), Nginx ConfigMap, Deployment, and Service.

Nginx with NFS Storage: The Nginx application is configured to serve content from the provisioned NFS share.

Basic Connectivity Check: After deployment, the script attempts to curl the Nginx pod to verify access to the NFS-mounted content.

Non-Root Execution: Ensures the script is not run as a root user, promoting secure practices.

Prerequisites
Before running this script, ensure you have:

K3s Cluster: A running K3s cluster on the machine where you intend to run this script.

kubectl: Configured to interact with your K3s cluster.

sudo: The user running the script must have sudo privileges.

DNF-based Linux Distribution: The script currently uses dnf for package management, so it's designed for distributions like Fedora, CentOS, or RHEL.

Usage
Clone the Repository:

Bash

git clone <your-repo-url>
cd nfs_task # Or whatever your project directory is named
Run the Deployment Script:
Execute the deploy-nfs.sh script. It will handle the NFS server setup and Kubernetes resource deployment.

Bash

./deploy-nfs.sh
The script will:

Check if it's being run as a non-root user.

Detect your operating system.

Install nfs-utils and enable nfs-server and rpcbind services.

Create the NFS shared directory /srv/nfs/k3s and export it.

Apply all Kubernetes manifests from the manifests/ directory.

Attempt to access the Nginx pod's web page to confirm NFS access.

Manifests Explained
nfs-pv.yaml: Defines a Kubernetes Persistent Volume (PV) that represents the NFS share /srv/nfs/k3s on your host machine.

nfs-pvc.yaml: Defines a Persistent Volume Claim (PVC) that requests storage from the nfs-pv. This is what your Nginx application will use.

nginx-configmap.yaml: Creates a ConfigMap for Nginx, which can be used to store configuration files or other data for the Nginx server.

nginx-deployment.yaml: Defines the Nginx deployment, creating replica pods that mount the PVC and serve content.

nginx-service.yaml: Creates a Kubernetes Service to expose the Nginx pods, making them accessible within the cluster.

Author
Yaniv Mendiuk

Version
1.1.0
