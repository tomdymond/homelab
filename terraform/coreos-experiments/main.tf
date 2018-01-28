module "vm" {
  node_base_name="coreos-experiments"
  source="../source/vsphere-vm/"
  guest_id="coreos64Guest"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB3"
}

