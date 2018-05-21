#provider "vault" {
#  address = "http://127.0.0.1:8200"
#}

provider "aws" {
#  access_key = "${local.aws_access_key}"
#  secret_key = "${local.aws_secret_key}"
  region     = "${var.region}"
}

