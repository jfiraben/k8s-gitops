output "argocd_namespace" {
  value = kubernetes_namespace.argocd.metadata[0].name
}

output "gitea_namespace" {
  value = kubernetes_namespace.gitea.metadata[0].name
}

output "monitoring_namespace" {
  value = kubernetes_namespace.monitoring.metadata[0].name
}

output "vault_namespace" {
  value = kubernetes_namespace.vault.metadata[0].name
}

output "storage_namespace" {
  value = kubernetes_namespace.storage.metadata[0].name
}

output "media_namespace" {
  value = kubernetes_namespace.media.metadata[0].name
}

output "security_namespace" {
  value = kubernetes_namespace.security.metadata[0].name
}

output "management_namespace" {
  value = kubernetes_namespace.management.metadata[0].name
}