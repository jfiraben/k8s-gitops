variable "argocd_namespace" {
  description = "Namespace for ArgoCD"
  type        = string
}

variable "gitea_namespace" {
  description = "Namespace for Gitea"
  type        = string
}

variable "monitoring_namespace" {
  description = "Namespace for Monitoring"
  type        = string
}

variable "security_namespace" {
  description = "Namespace for Security"
  type        = string
}

variable "management_namespace" {
  description = "Namespace for Management"
  type        = string
}

variable "media_namespace" {
  description = "Namespace for Media"
  type        = string
}

variable "vault_namespace" {
  description = "Namespace for Vault"
  type        = string
}

variable "storage_namespace" {
  description = "Namespace for Storage"
  type        = string
}

variable "repository" {
  description = "Helm chart repository"
  type        = map(string)
}

variable "values" {
  description = "Values files for the Helm releases"
  type        = map(string)
}
