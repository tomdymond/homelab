module "vm" {
  vault_password="bar"
  vault_username="foo"
  vsphere_server="127.0.0.1:8443"
  node_base_name="haproxy-experiments"
  source="../source/vsphere-vm/"
  guest_id="centos7_64Guest"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
  memory="2048"
  vcpu="1"
  deploy_stack="haproxy-stack"
  user_variables="BACKEND_SERVERS=192.168.1.34,192.168.1.38!APP_PORT=80!MAXCONN=500!CHECK_PORT=80!FE_PORT=80"
}

