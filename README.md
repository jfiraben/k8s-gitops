# gitops

## Table of Contents
- [Summary](#summary)
- [Repository Structure](#repository-structure)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
    - [1. Clone the Repository](#1-clone-the-repository)
    - [2. Install ArgoCD](#2-install-argocd)
    - [3. Apply Namespace Configurations](#3-apply-namespace-configurations)
    - [4. Deploy Applications](#4-deploy-applications)
- [Port-Forwarding](#port-forwarding)
    - [Gitea](#gitea)
    - [Grafana](#grafana)
    - [ArgoCD](#argocd)
    - [Vault](#vault)
- [Accessing the UIs](#accessing-the-uis)
- [Contributing](#contributing)
- [License](#license)
- [Accessing Talos K8s Cluster](#accessing-talos-k8s-cluster)

## Summary
This repository contains the configuration files and manifests required to deploy and manage various applications using GitOps principles with ArgoCD. The applications include Gitea, Grafana, Prometheus, and Traefik, among others. The repository is structured to facilitate easy deployment and management of these applications in a Kubernetes environment.

## Repository Structure
```
.
├── LICENSE
├── README.md
├── applications
│   ├── gitea-application.yaml
│   ├── gitea-helmrepository.yaml
│   ├── traefik-application.yaml
│   └── traefik-helmrepository.yaml
├── argocd
│   └── argocd-operator.yaml
├── argocd-apps
│   ├── grafana-app.yaml
│   ├── namespaces-app.yaml
│   └── prometheus-app.yaml
├── argocd-repo-server-backup.yaml
├── current-values.yaml
├── gitea
│   ├── gitea-helmrelease.yaml
│   ├── gitea-ingress.yaml
│   ├── gitea-tls.crt
│   ├── gitea-tls.key
│   └── gitea-values.yaml
├── grafana
│   ├── deployment.yaml
│   ├── secret.yaml
│   └── service.yaml
├── namespaces
│   ├── argocd-namespace.yaml
│   ├── gitea-namespace.yaml
│   ├── monitoring-namespace.yaml
│   ├── storage-namespace.yaml
│   ├── traefik-namespace.yaml
│   └── vault-namespace.yaml
├── prometheus
│   ├── config.yaml
│   ├── deployment.yaml
│   └── service.yaml
├── storage
│   ├── nfs-provisioner-deployment.yaml
│   ├── nfs-provisioner-values.yaml
│   ├── nfs-storageclass.yaml
│   ├── nfs-test-pod.yaml
│   ├── pvc.yaml
│   ├── redis-values.yaml
│   └── test-pvc.yaml
├── traefik
│   ├── traefik-helmrelease.yaml
│   └── traefik-values.yaml
└── values.yaml
```

## Prerequisites
- Kubernetes cluster
- kubectl configured to interact with your cluster
- Helm installed
- ArgoCD installed and configured

## Setup Instructions

### 1. Clone the Repository
```sh
git clone http://gitea-http.gitea.svc.cluster.local:3000/gitops.git
cd gitops
```

### 2. Install ArgoCD
Follow the official [ArgoCD installation guide](https://argo-cd.readthedocs.io/en/stable/getting_started/) to install ArgoCD in your Kubernetes cluster.

### 3. Apply Namespace Configurations
```sh
kubectl apply -f namespaces/argocd-namespace.yaml
kubectl apply -f namespaces/gitea-namespace.yaml
kubectl apply -f namespaces/monitoring-namespace.yaml
kubectl apply -f namespaces/storage-namespace.yaml
kubectl apply -f namespaces/traefik-namespace.yaml
kubectl apply -f namespaces/vault-namespace.yaml
```

### 4. Deploy Applications
```sh
kubectl apply -f argocd-apps/grafana-app.yaml
kubectl apply -f argocd-apps/namespaces-app.yaml
kubectl apply -f argocd-apps/prometheus-app.yaml
kubectl apply -f argocd-apps/vault-app.yaml
kubectl apply -f applications/gitea-application.yaml
kubectl apply -f applications/traefik-application.yaml
```

## Port-Forwarding

### Gitea
```sh
kubectl port-forward -n gitea svc/gitea 3000:3000
```

### Grafana
```sh
kubectl port-forward -n monitoring svc/grafana 3001:80
```

### ArgoCD
```sh
kubectl port-forward -n argocd svc/argocd-server 8080:443
```

### Vault
```sh
kubectl port-forward -n vault svc/vault 8200:8200
```

## Accessing the UIs

### Gitea
- URL: `http://localhost:3000`
- Default credentials: `admin` / `password` (or as configured)

### Grafana
- URL: `http://localhost:3001`
- Default credentials: `admin` / `password` (or as configured in the secret)

### ArgoCD
- URL: `http://localhost:8080`
- Default credentials: `admin` / `password` (initial password is the ArgoCD server pod name)

### Vault
- URL: `http://localhost:8200`
- Default credentials: As configured in the Vault setup

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## License
This repository is licensed under the MIT License. See the LICENSE file for more information.

## Accessing Talos K8s Cluster
To ensure the new Talos K8s cluster is accessible from your local machine, follow these steps:
```sh
export TALOSCONFIG="_out/talosconfig"
talosctl kubeconfig _out/.
export KUBECONFIG=$HOME/.kube/config:_out/kubeconfig
kubectl config view --flatten > $HOME/.kube/config-merged
mv $HOME/.kube/config-merged $HOME/.kube/config
```
