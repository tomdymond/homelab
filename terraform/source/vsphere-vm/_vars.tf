variable bootstrap_network {}
variable vsphere_user {}
variable vsphere_password {}
variable vsphere_server {
  default = "192.168.1.254"
}
variable node_base_name {
  default = "foobar"
}
variable master_count {
  default = 1
}
variable memory {
  default = "2048"
}
variable vcpu {
  default = "2"
}

variable guest_id {
  default = "centos7Guest"
}

variable iface_priv_use_static_mac {
  default = "false"
}

variable iface_pub_use_static_mac {
  default = "false"
}

variable iface_priv_mac_address {
  default = "aa:aa:aa:aa:aa:aa"
}

variable iface_pub_mac_address {
  default = "aa:aa:aa:aa:11:aa"
}

