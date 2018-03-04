module "consul_boot" {
  vsphere_server="192.168.1.254"
  node_base_name="consul-boot"
  source="../source/vsphere-vm/"
  guest_id="centos7_64Guest"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
  memory="4096"
  vcpu="2"
  deploy_stack="consul-stack"
  user_variables="CONSUL_ROLE=bootstrap"
}
module "consul_joiners" {
  vsphere_server="192.168.1.254"
  node_base_name="consul-joiners"
  source="../source/vsphere-vm/"
  guest_id="centos7_64Guest"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
  memory="4096"
  vcpu="2"
  deploy_stack="consul-stack"
  user_variables="CONSUL_ROLE=join!CONSUL_BOOTSTRAP_NODE=${module.consul_boot.host_ip}"
  master_count=2
}
