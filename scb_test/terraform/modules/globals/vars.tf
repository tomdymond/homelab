variable amis {
  type = "map"

  default = {
    "web" = "ami-0e77ff9cdf27b9833"
    "app" = "ami-07e171432336f8583"
    "db"  = "ami-07890c78e20be5724"
  }
}

variable instance_types {
  type = "map"

  default = {
    "web"     = "t2.micro"
    "app"     = "t2.micro"
    "db"      = "t2.micro"
    "bastion" = "t2.micro"
  }
}

variable securitygroups {
  type = "map"

  default = {
    "web" = "secgroup_web"
    "app" = "secgroup_app"
    "db"  = "secgroup_db"
  }
}

variable key_name {
  default = "tom-aws-virginia"
}
