module "mesos_master" {
  vsphere_server="192.168.1.254"
  node_base_name="mesos-boot"
  source="../source/vsphere-vm/"
  guest_id="centos7_64Guest"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
  memory="4096"
  vcpu="2"
  deploy_stack="mesosphere-stack"
  user_variables="MESOSPHERE_ROLE=master"
  master_count=3
}

module "mesos_priv_agents" {
  vsphere_server="192.168.1.254"
  node_base_name="mesos-joiners"
  source="../source/vsphere-vm/"
  guest_id="centos7_64Guest"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
  memory="2048"
  vcpu="2"
  deploy_stack="mesosphere-stack"
  user_variables="MESOSPHERE_ROLE=slave"
  master_count=1
}

