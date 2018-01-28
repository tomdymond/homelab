module "vm" {
  node_base_name="centos-jumphost"
  source="../source/vsphere-vm/"
  guest_id="centos7_64Guest"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
  memory="2048"
  vcpu="2"
  iface_pub_use_static_mac = "true"
  iface_pub_mac_address = "00:0A:29:3F:D1:DE"
}

