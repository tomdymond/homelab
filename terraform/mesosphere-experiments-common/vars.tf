
# Sandbox specific settings

variable "bootstrap_node" {
  type = "map"
  default = {
    tomtest = "mesos-bootstrap01.local.lab"
    foo = "mesos-foo01.local.lab"
  }
}

variable "mesosphere_ingress_lb_vip" {
  type = "map"
  default = {
    tomtest = "192.168.1.129"
    foo = "x.x.x.x"
  }
}

variable "mesosphere_master_vip" {
  type = "map"
  default = {
    tomtest = "192.168.1.128"
    foo = "x.x.x.x"
  }
}

variable "dcos_edition" {
  type = "map"
  default = {
    tomtest = "enterprise"
    foo = "standard"
  }
}

variable "dcos_version" {
  type = "map"
  default = {
    tomtest = "1.11.0"
    foo = "1.10.0"
  }
}

# DC Specific settings
variable "default_dns_server" {
  type = "map"
  default = { 
    home = "192.168.1.1"
    vdc = "x.x.x.x"
  }
}

output "bootstrap_node" {
  value = "${var.bootstrap_node}"
}


output "dcos_version" {
  value = "${var.dcos_version}"
}

output "mesosphere_master_vip" {
  value = "${var.mesosphere_master_vip}"
}

output "dcos_edition" {
  value = "${var.dcos_edition}"
}

output "mesosphere_ingress_lb_vip" {
  value = "${var.mesosphere_ingress_lb_vip}"
}

output "default_dns_server" {
  value = "${var.default_dns_server}"
}
