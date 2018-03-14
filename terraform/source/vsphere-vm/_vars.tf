variable bootstrap_network {}
variable vsphere_user {}
variable vsphere_password {}
variable vsphere_server {
  default = "192.168.1.254"
}
variable consul_vip {
  default = "192.168.1.127"  
}
variable consul_servers {
  default = "192.168.1.15,192.168.1.16,192.168.1.17"  
}
variable vault_username {
  default = "foo"  
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
variable vault_token {
  default = "XXXXXXXXXXXXX"
}

variable deploy_stack {
  default = "base"
}
variable user_variables {
  default = "CONSUL_ROLE=client!CONSUL_BOOTSTRAP_NODE=192.168.1.15"
}

