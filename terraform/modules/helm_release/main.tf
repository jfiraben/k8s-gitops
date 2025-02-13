resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = var.argocd_namespace
  repository = var.repository["argocd"]
  chart      = "argo-cd"
  values     = [file(var.values["argocd"])]
}

resource "helm_release" "gitea" {
  name       = "gitea"
  namespace  = var.gitea_namespace
  repository = var.repository["gitea"]
  chart      = "gitea"
  values     = [file(var.values["gitea"])]
}

resource "helm_release" "vault" {
  name       = "vault"
  namespace  = var.vault_namespace
  repository = var.repository["vault"]
  chart      = "vault"
  values     = [file(var.values["vault"])]
}