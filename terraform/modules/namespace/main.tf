resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
    labels = {
      "argocd.argoproj.io/instance" = "namespaces"
    }
  }
}

resource "kubernetes_namespace" "gitea" {
  metadata {
    name = "gitea"
    labels = {
      "argocd.argoproj.io/instance" = "namespaces"
    }
  }
}

resource "kubernetes_namespace" "storage" {
  metadata {
    name = "storage"
    labels = {
      "argocd.argoproj.io/instance" = "namespaces"
    }
  }
}

# Vault
resource "kubernetes_namespace" "vault" {
  metadata {
    name = "vault"
    labels = {
      "argocd.argoproj.io/instance" = "namespaces"
    }
  }
}

# Media
resource "kubernetes_namespace" "media" {
  metadata {
    name = "media"
    labels = {
      "argocd.argoproj.io/instance" = "namespaces"
    }
  }
}

# Monitoring
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
    labels = {
      "argocd.argoproj.io/instance" = "namespaces"
    }
  }
}

# Security
resource "kubernetes_namespace" "security" {
  metadata {
    name = "security"
    labels = {
      "argocd.argoproj.io/instance" = "namespaces"
    }
  }
}

# Management
resource "kubernetes_namespace" "management" {
  metadata {
    name = "management"
    labels = {
      "argocd.argoproj.io/instance" = "namespaces"
    }
  }
}