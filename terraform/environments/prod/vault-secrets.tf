/*
resource "vault_generic_secret" "gitea_secrets" {
  path = "gitea/data/config"

  data_json = jsonencode({
    db_username = var.gitea_db_username
    db_password = var.gitea_db_password
  })
}

resource "vault_generic_secret" "argocd_secrets" {
  path = "argocd/data/config"

  data_json = jsonencode({
    admin_password = var.argocd_admin_password
  })
}

resource "vault_generic_secret" "vault_secrets" {
  path = "vault/data/config"

  data_json = jsonencode({
    vault_root_token = var.vault_root_token
    unseal_keys_b64 = var.vault_unseal_keys_b64
    unseal_keys_hex = var.vault_unseal_keys_hex
  })
}
*/