# master,slave,slave_public

variable "boostrap_node" {
  default = "mesos-bootstrap01.local.lab"
}
variable "vsphere_server" {
  default = "127.0.0.1:8443"
}
variable "cluster_name" {
  default = "tomtest"
}
variable "default_dns_server" {
  default = "192.168.1.1"
}

module "mesos_bootstrap" {
  vsphere_server="${var.vsphere_server}"
  node_base_name="mesos-bootstrap"
  source="../source/vsphere-vm/"
  guest_id="centos7_64Guest"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
  memory="2048"
  vcpu="2"
  deploy_stack="mesosphere-bootstrap-stack"
  user_variables="MESOSPHERE_ROLE=bootstrap!MESOSPHERE_CLUSTER_NAME=${var.cluster_name}!MESOSPHERE_RESOLVER=${var.default_dns_server}!MESOS_MASTERS=${module.mesos_master.host_ip}!MESOS_AGENTS_PRIV=${module.mesos_slave_private.host_ip}!MESOS_AGENTS_PUBLIC=${module.mesos_slave_public.host_ip}"
  master_count=1
}

module "mesos_master" {
  vsphere_server="${var.vsphere_server}"
  node_base_name="mesos-master"
  source="../source/vsphere-vm/"
  guest_id="centos7_64Guest"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
  memory="4096"
  vcpu="2"
  deploy_stack="mesosphere-bootstrap-discovery-stack"
  user_variables="MESOSPHERE_ROLE=master!MESOS_BOOTSTRAP=${var.boostrap_node}"
  master_count=3
}

module "mesos_slave_private" {
  vsphere_server="${var.vsphere_server}"
  node_base_name="mesos-slave-private"
  source="../source/vsphere-vm/"
  guest_id="centos7_64Guest"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
  memory="4096"
  vcpu="2"
  deploy_stack="mesosphere-bootstrap-discovery-stack"
  user_variables="MESOSPHERE_ROLE=slave!MESOS_BOOTSTRAP=${var.boostrap_node}"
  master_count=3
}

module "mesos_slave_public" {
  vsphere_server="${var.vsphere_server}"
  node_base_name="mesos-slave-public"
  source="../source/vsphere-vm/"
  guest_id="centos7_64Guest"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
  memory="4096"
  vcpu="2"
  deploy_stack="mesosphere-bootstrap-discovery-stack"
  user_variables="MESOSPHERE_ROLE=slave_public!MESOS_BOOTSTRAP=${var.boostrap_node}"
  master_count=2
}
  
module "service_lb" {
  vsphere_server="${var.vsphere_server}"
  node_base_name="service_lb"
  source="../source/vsphere-vm/"
  guest_id="centos7_64Guest"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
  memory="1024"
  vcpu="2"
  deploy_stack="haproxy-stack"
  user_variables="MESOS_MASTERS=${module.mesos_master.host_ip}"
  master_count=1
}

