#variable dc {}

variable consul_vip {
  type = "map"
  default = {
    home = "192.168.1.127"
  }
}

variable pxe_server {
  type = "map"
  default = {
    home = "192.168.1.33"
  }
}

variable "vsphere_server" {
  type = "map"
  default = {
    home = "192.168.1.254"
    vdc = "x.x.x.x"
  }
}

variable consul_servers {
  type = "map"
  default = {
    home = "192.168.1.15,192.168.1.16,192.168.1.17"
  }
}

variable dockerdisk_size_gb {
  type = "map"
  default = {
    small  = "15"
    medium = "25"
    large  = "25"  
  }
}

variable datadisk_size_gb {
  type = "map"
  default = {
    small  = "16"
    medium = "26"
    large  = "26"  
  }
}


variable mem {
  type = "map"
  default = {
    small  = "1024"
    medium = "2048"
    large  = "4096"
  }
}

variable vcpu {
  type = "map"
  default = {
    small  = "1"
    medium = "2"
    large  = "2"
  }
}

output mem {
  value = "${var.mem}"
}

output vcpu {
  value = "${var.vcpu}"
}

output vsphere_server {
  value = "${var.vsphere_server}"
}

output consul_servers {
  value = "${var.consul_servers}"
}

output pxe_server {
  value = "${var.pxe_server}"
}

output consul_vip {
  value = "${var.consul_vip}"
}

output dockerdisk_size_gb {
  value = "${var.dockerdisk_size_gb}"
}

output datadisk_size_gb {
  value = "${var.datadisk_size_gb}"
}

