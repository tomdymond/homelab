provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"

  # if you have a self-signed cert
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


resource "vsphere_virtual_machine" "vm" {
  name             = "${var.node_base_name}${format("%02d", count.index)}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  num_cpus = 2
  memory   = 2048
  guest_id = "${var.guest_id}"

  wait_for_guest_net_timeout = 60
  network_interface {
    network_id = "${data.vsphere_network.network_priv.id}"
#    use_static_mac = "true"
#    mac_address = "${var.mac_address}"
  }
  network_interface {
    network_id = "${data.vsphere_network.network_pub.id}"
  }


  disk {
    label = "disk0"
    size  = 20
    thin_provisioned = true
  }
  count = "${var.master_count}"
}
