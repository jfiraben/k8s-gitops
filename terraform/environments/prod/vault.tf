/*
resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
  path = "kubernetes"
}


resource "vault_mount" "app_kv" {
  for_each = toset(var.applications)

  path        = each.value
  type        = "kv"
  description = "KV secrets engine for ${each.value}"
  options = {
    version = "2"
  }
}

resource "vault_policy" "app_policy" {
  for_each = toset(var.applications)

  name   = "${each.value}-policy"
  policy = <<EOT
path "${each.value}/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOT
}
*/