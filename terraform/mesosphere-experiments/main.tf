module "mesos_master" {
  vsphere_server="192.168.1.254"
  node_base_name="consul-boot"
  source="../source/vsphere-vm/"
  guest_id="centos7_64Guest"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
  memory="4096"
  vcpu="2"
  deploy_stack="mesosphere-stack"
  user_variables="MESOSPHERE_ROLE=master"
  count=3
}

module "mesos_priv_agents" {
  vsphere_server="192.168.1.254"
  node_base_name="consul-joiners"
  source="../source/vsphere-vm/"
  guest_id="centos7_64Guest"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
  memory="2048"
  vcpu="2"
  deploy_stack="consul-stack"
  user_variables="MESOSPHERE_ROLE=slave!MESOS_MASTERS=${module.mesos_master.*.host_ip}"
  master_count=1
}

module "mesos_public_agents" {
  vsphere_server="192.168.1.254"
  node_base_name="consul-joiners"
  source="../source/vsphere-vm/"
  guest_id="centos7_64Guest"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
  memory="2048"
  vcpu="2"
  deploy_stack="consul-stack"
  user_variables="MESOSPHERE_ROLE=slave!MESOS_MASTERS=${module.mesos_master.*.host_ip}"
  master_count=1
}


