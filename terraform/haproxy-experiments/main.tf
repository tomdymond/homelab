module "vm" {
  vsphere_server="192.168.1.254"
  node_base_name="haproxy-experiments"
  source="../source/vsphere-vm/"
  guest_id="centos7_64Guest"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
  memory="1024"
  vcpu="1"
  deploy_stack="haproxy-stack"
}
