module "web" {
  source        = "../../ami-public"
  node_role     = "web"
  azs           = "${var.azs}"
  securitygroup = "${var.securitygroup_web}"
  subnetid      = "${var.subnet_id_public}"
  zone_id       = "${var.zone_id}"
  aws_elb_id    = "${var.aws_elb_id}"
}

module "app" {
  source        = "../../ami"
  node_role     = "app"
  azs           = "${var.azs}"
  securitygroup = "${var.securitygroup_app}"
  subnetid      = "${var.subnet_id_private}"
  zone_id           = "${var.zone_id}"
  database_password = "${var.database_password}"
}

module "db" {
  source            = "../../ami"
  node_role         = "db"
  azs               = "${var.azs}"
  securitygroup     = "${var.securitygroup_db}"
  subnetid          = "${var.subnet_id_database}"
  zone_id           = "${var.zone_id}"
  database_password = "${var.database_password}"
}
