# 📦 K3s NFS Application Deployment

This project provides a simple, automated solution for setting up an NFS server and deploying an Nginx application on a **K3s (Lightweight Kubernetes)** cluster that utilizes the NFS share for its persistent storage.

---

## 📁 Project Structure

.
├── deploy-nfs.sh
├── manifests
│ ├── nfs-pvc.yaml
│ ├── nfs-pv.yaml
│ ├── nginx-configmap.yaml
│ ├── nginx-deployment.yaml
│ └── nginx-service.yaml
└── README.md


---

## ✨ Features

- **Automated NFS Setup**  
  Installs required NFS utilities and configures an export on the host machine.

- **K3s Resource Deployment**  
  Deploys PV, PVC, ConfigMap, Deployment, and Service resources to the Kubernetes cluster.

- **Nginx with NFS Storage**  
  Nginx serves content directly from the provisioned NFS share.

- **Connectivity Check**  
  Performs a `curl` test to verify that Nginx is serving content from the NFS volume.

- **Non-Root Execution**  
  Script checks and enforces that it is not run as root for better security.

---

## ⚙️ Prerequisites

Before running the script, make sure you have the following:

- ✅ A running **K3s cluster**
- ✅ `kubectl` configured to access the cluster
- ✅ `sudo` privileges on the host machine
- ✅ A **DNF-based Linux distribution** (e.g., RHEL, CentOS, Fedora)

---

## 🚀 Usage

### 1. Clone the Repository

```bash
git clone <your-repo-url>
cd nfs_task  # Adjust if your folder is named differently
```

### 2. Run the Deployment Script

```bash
./deploy-nfs.sh
```

### This script will:

- Verify it's not being run as root

- Detect your operating system

- Install NFS utilities

- Start NFS services (nfs-server, rpcbind)

- Create and export the /srv/nfs/k3s shared directory

- Apply Kubernetes manifests from the manifests/ directory

- Use curl to verify Nginx is correctly serving content

### 📜 Manifests Explained

- nfs-pv.yaml
Defines a Persistent Volume backed by the local NFS export.

- nfs-pvc.yaml
Creates a Persistent Volume Claim to request storage from the PV.

- nginx-configmap.yaml
Custom Nginx configuration, including setting the server to listen on port 1234.

- nginx-deployment.yaml
Deploys Nginx pods with the NFS volume mounted at /usr/share/nginx/html.

- nginx-service.yaml
Exposes the Nginx deployment using a NodePort service.

---

## 👤 Author
**Yaniv Mendiuk**
