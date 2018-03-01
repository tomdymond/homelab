module "vm" {
  vsphere_server="192.168.1.254"
  node_base_name="minio-experiments"
  source="../source/vsphere-vm/"
  guest_id="centos7_64Guest"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
  memory="4096"
  vcpu="2"
  deploy_stack="minio-stack"
  user_variables="CONSUL_SERVER_ROLE=bootstrap"
}
