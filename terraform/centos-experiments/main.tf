module "vm" {
  node_base_name="centos-experiments"
  source="../source/vsphere-vm/"
  guest_id="centos7_64Guest"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
}
