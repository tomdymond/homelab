module "globals" {
  source="../../globals/"
}

provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${lookup(module.globals.vsphere_server, var.dc)}"
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "dc1"
}

data "vsphere_datastore" "datastore" {
  name          = "datastore1"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "cluster1/Resources"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network_priv" {
  name          = "${var.bootstrap_network}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network_pub" {
  name          = "VM Network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}


data "template_file" "base_userdata" {
  count    = "${var.master_count}"
  template = "${file("${path.module}/user_data")}"

  vars {
    node_base_name         = "${var.node_base_name}"
    vault_token            = "${var.vault_token}"
    ansible_vault_password = "${base64encode(file("~/.ansible_vault_password"))}"
    deploy_stack           = "${var.deploy_stack}"
    user_variables         = "${var.user_variables}"
    consul_vip             = "${lookup(module.globals.consul_vip, var.dc)}"
    consul_servers         = "${lookup(module.globals.consul_servers, var.dc)}"
    vault_username         = "${var.vault_username}"
    vault_password         = "${var.vault_password}"
    pxe_server             = "${lookup(module.globals.pxe_server, var.dc)}"
    git_repo               = "${var.git_repo}"
  }
}


resource "vsphere_virtual_machine" "vm" {
  name             = "${var.node_base_name}${format("%02d", count.index+1)}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  num_cpus         = "${lookup(module.globals.vcpu, var.profile)}"
  memory           = "${lookup(module.globals.mem, var.profile)}"
  guest_id         = "${var.guest_id}"

  wait_for_guest_net_timeout = 60
  network_interface {
    network_id     = "${data.vsphere_network.network_priv.id}"
    use_static_mac = "${var.iface_priv_use_static_mac}"
    mac_address    = "${var.iface_priv_mac_address}"
  }
  network_interface {
    network_id     = "${data.vsphere_network.network_pub.id}"
    use_static_mac = "${var.iface_pub_use_static_mac}"
    mac_address    = "${var.iface_pub_mac_address}"
  }


  disk {
    label            = "${var.node_base_name}${format("%02d", count.index+1)}-os"
    size             = 10
    thin_provisioned = true
    unit_number      = 0
  }

  disk {
    label            = "${var.node_base_name}${format("%02d", count.index+1)}-docker"
    size             = "${lookup(module.globals.dockerdisk_size_gb, var.profile)}"
    thin_provisioned = true
    unit_number      = 1
  }

  disk {
    label            = "${var.node_base_name}${format("%02d", count.index+1)}-data"
    size             = "${lookup(module.globals.datadisk_size_gb, var.profile)}"
    thin_provisioned = true
    unit_number      = 2
  }


  extra_config = {
    "guestinfo.cloudinit.userdata"              = "${base64encode(replace(format("%s", data.template_file.base_userdata.*.rendered[count.index]), "$${count_index}", format("%02d", count.index+1)))}"
    "guestinfo.cloudinit.userdata.encoding"     = "base64"
  }

  count = "${var.master_count}"
}

output "host_ip" {
  value = "${join(",",vsphere_virtual_machine.vm.*.default_ip_address)}"
}

