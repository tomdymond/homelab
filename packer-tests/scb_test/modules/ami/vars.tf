variable azs {
  type = "list"
}

variable master_count {
  default = 1
}

variable node_role {}

variable instance_tags {
  default = "ami"
}

variable securitygroup {}

variable subnetid {
  type = "list"
}

variable app_server_ips {
  default = ""
}

variable db_server_ips {
  default = ""
}

variable zone_id {}

variable database_password {
  default = ""
}
