module "web" {
  source    = "../../ami"
  node_role = "web"
  azs       = "${var.azs}"
  securitygroup = "${var.securitygroup_web}"
  subnetid = "${var.subnet_id_public}"
#  app_server_ips = "${module.app.private_ip}"
  zone_id = "${var.zone_id}"
}

module "app" {
  source = "../../ami"
  node_role = "app"
  azs       = "${var.azs}"
  securitygroup = "${var.securitygroup_app}"
  subnetid = "${var.subnet_id_private}"
#  database_server_ips = "${module.db.private_ip}"
  zone_id = "${var.zone_id}"
}

module "db" {
  source = "../../ami"
  node_role = "db"
  azs       = "${var.azs}"
  securitygroup = "${var.securitygroup_db}"
  subnetid = "${var.subnet_id_database}"
  zone_id = "${var.zone_id}"
}

