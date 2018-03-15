variable "boostrap_node" {
  default = "mesos-bootstrap01.local.lab"
}

variable "mesosphere_master_vip" {
  type = "map"
  default = {
    home = "192.168.1.128"
    vdc = "x.x.x.x"
  }
}

variable "default_dns_server" {
  type = "map"
  default = { 
    home = "192.168.1.1"
    vdc = "x.x.x.x"
  }
}

variable "dcos_version" {
  default = "1.11.0"
}
variable "dcos_edition" {
  default = "enterprise"
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

output "boostrap_node" {
  value = "${var.boostrap_node}"
}

output "default_dns_server" {
  value = "${var.default_dns_server}"
}
