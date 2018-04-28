variable aws_access_key {}
variable aws_secret_key {}

variable private_subnets {
  type = "list"
}

variable public_subnets {
  type = "list"
}

variable database_subnets {
  type = "list"
}

variable region {
  default = "us-east-1"
}

variable vpc_subnet {}

variable azs {
  type = "list"
}
