module "mesos_bootstrap" {
  vsphere_server="192.168.1.254"
  node_base_name="mesos-bootstrap"
  source="../source/vsphere-vm/"
  guest_id="centos7_64Guest"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
  memory="4096"
  vcpu="2"
  deploy_stack="mesosphere-bootstrap-stack"
  user_variables="MESOSPHERE_ROLE=bootstrap!MESOSPHERE_CLUSTER_NAME=tomtest!MESOSPHERE_RESOLVER=192.168.1.1!MESOS_MASTERS=${module.mesos_master.host_ip}!MESOS_AGENTS_PRIV=${module.mesos_slave.host_ip}"
  master_count=1
}

module "mesos_master" {
  vsphere_server="192.168.1.254"
  node_base_name="mesos-master"
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

module "mesos_slave" {
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

