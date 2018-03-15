variable bootstrap_network {}
variable vsphere_user {}
variable vsphere_password {}
variable profile {
  default = "small"
}
variable vault_username {
  default = "foo"  
}

variable dc {
  default = "home"
}
variable vault_password {
  default = "bar"
}
variable node_base_name {
  default = "foobar"
}
variable master_count {
  default = 1
}

variable guest_id {
  default = "centos7_64Guest"
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
variable vault_token {
  default = "XXXXXXXXXXXXX"
}

variable deploy_stack {
  default = "base"
}
variable user_variables {
  default = "CONSUL_ROLE=client"
}

