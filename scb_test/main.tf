provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}

module "vpc" {
  source           = "modules/vpc"
  vpc_subnet       = "${var.vpc_subnet}"
  private_subnets  = "${var.private_subnets}"
  public_subnets   = "${var.public_subnets}"
  database_subnets = "${var.database_subnets}"
  azs              = "${var.azs}"
}

module "stack" {
  source             = "modules/stacks/lamp"
  azs                = "${var.azs}"
  securitygroup_web  = "${module.vpc.securitygroup_web}"
  securitygroup_app  = "${module.vpc.securitygroup_app}"
  securitygroup_db   = "${module.vpc.securitygroup_db}"
  subnet_id_private  = "${module.vpc.subnet_id_private}"
  subnet_id_public   = "${module.vpc.subnet_id_public}"
  subnet_id_database = "${module.vpc.subnet_id_database}"
  zone_id            = "${module.vpc.zone_id}"
  aws_elb_id         = "${module.vpc.aws_elb_id}"
  database_password  = "${var.database_password}"
}

