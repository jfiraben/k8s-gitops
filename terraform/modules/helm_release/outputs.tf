output "gitea_helm_release_name" {
  value = helm_release.gitea.name
}

output "gitea_helm_release_namespace" {
  value = helm_release.gitea.namespace
}

output "vault_helm_release_name" {
  value = helm_release.vault.name
}

output "vault_helm_release_namespace" {
  value = helm_release.vault.namespace
}

output "argocd_helm_release_name" {
  value = helm_release.argocd.name
}

output "argocd_helm_release_namespace" {
  value = helm_release.argocd.namespace
}
