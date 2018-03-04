module "elk" {
  vsphere_server="192.168.1.254"
  node_base_name="consul-boot"
  source="../source/vsphere-vm/"
  guest_id="centos7_64Guest"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
  memory="4096"
  vcpu="2"
  deploy_stack="elk-stack"
  user_variables="ES_ROLE=MDC!ES_MEMORY_GB=2"
  master_count=3
}

