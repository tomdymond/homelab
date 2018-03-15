module "globals" {
  source="../globals"
  dc = "${var.dc}"
}

module "mesos_common" {
  source="../mesosphere-experiments-common"
}

module "mesos_bootstrap" {
  dc = "${var.dc}"
  node_base_name="mesos-bootstrap"
  source="../source/vsphere-vm/"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
  profile="medium"
  deploy_stack="mesosphere-bootstrap-stack"
  user_variables="MESOSPHERE_ROLE=bootstrap!MESOSPHERE_CLUSTER_NAME=${var.cluster_name}!MESOSPHERE_RESOLVER=${lookup(module.mesos_common.default_dns_server, var.dc)}!MESOS_MASTERS=${module.mesos_master.host_ip}!MESOS_AGENTS_PRIV=${module.mesos_slave_private.host_ip}!MESOS_AGENTS_PUBLIC=${module.mesos_slave_public.host_ip}!DCOS_VERSION=${module.mesos_common.dcos_version}!DCOS_EDITION=${module.mesos_common.dcos_edition}"
  master_count=1
}

module "mesos_master" {
  dc = "${var.dc}"
  node_base_name="mesos-master"
  source="../source/vsphere-vm/"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
  profile="large"
  deploy_stack="mesosphere-bootstrap-discovery-stack"
  user_variables="MESOSPHERE_ROLE=master!MESOS_BOOTSTRAP=${module.mesos_common.boostrap_node}!DCOS_VERSION=${module.mesos_common.dcos_version}!DCOS_EDITION=${module.mesos_common.dcos_edition}!MESOSPHERE_MASTER_VIP=${lookup(module.mesos_common.mesosphere_master_vip, var.dc)}"
  master_count=3
}

module "mesos_slave_private" {
  dc = "${var.dc}"
  node_base_name="mesos-slave-private"
  source="../source/vsphere-vm/"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
  profile="large"
  deploy_stack="mesosphere-bootstrap-discovery-stack"
  user_variables="MESOSPHERE_ROLE=slave!MESOS_BOOTSTRAP=${module.mesos_common.boostrap_node}!DCOS_VERSION=${module.mesos_common.dcos_version}!DCOS_EDITION=${module.mesos_common.dcos_edition}"
  master_count=1
}

module "mesos_slave_public" {
  dc = "${var.dc}"
  node_base_name="mesos-slave-public"
  source="../source/vsphere-vm/"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2"
  profile="large"
  deploy_stack="mesosphere-bootstrap-discovery-stack"
  user_variables="MESOSPHERE_ROLE=slave_public!MESOS_BOOTSTRAP=${module.mesos_common.boostrap_node}!DCOS_VERSION=${module.mesos_common.dcos_version}!DCOS_EDITION=${module.mesos_common.dcos_edition}"
  master_count=1
}

module "mesos_ingress_lb" {
  dc = "${var.dc}"
  node_base_name="mesos-ingress-lb"
  source="../source/vsphere-vm/"
  vsphere_password="${var.vsphere_password}"
  vsphere_user="${var.vsphere_user}"
  bootstrap_network="LAB2_LB"
  deploy_stack="ha-haproxy-stack"
  user_variables="MESOS_AGENTS_PUBLIC=${module.mesos_slave_public.host_ip}"
  master_count=2
}


