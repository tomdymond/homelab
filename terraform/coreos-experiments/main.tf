module "coreos-experiment" {
  node_base_name="mesos-agent-priv"
  source="../source/vsphere-vm/"
  guest_id="coreos64Guest"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB3"
  memory="2048"
  vcpu="2"
  master_count=4
}

