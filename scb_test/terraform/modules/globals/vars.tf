variable amis {
  type = "map"

  default = {
    "web" = "ami-09eb8379a09d8c236"
    "app" = "ami-09eb8379a09d8c236"
    "db"  = "ami-09eb8379a09d8c236"
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
