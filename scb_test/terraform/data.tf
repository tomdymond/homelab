data "vault_generic_secret" "aws_auth" {
  path = "secret/aws"
}

data "vault_generic_secret" "database" {
  path = "secret/database"
}
