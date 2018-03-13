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
  user_variables="BACKEND_SERVERS=192.168.1.34,192.168.1.38!APP_PORT=80!MAXCONN=500!CHECK_PORT=80!FE_PORT=80"
}

