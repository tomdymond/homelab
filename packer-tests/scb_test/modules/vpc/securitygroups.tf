resource "aws_security_group" "elb-securitygroup" {
  name        = "ELB"
  description = "ELB security group"
  vpc_id      = "${aws_vpc.main.id}"
}

resource "aws_security_group" "secgroup_web" {
  name        = "Web Servers"
  description = "Web servers security group"
  vpc_id      = "${aws_vpc.main.id}"
}

resource "aws_security_group" "secgroup_app" {
  name        = "App Servers"
  description = "App servers security group"
  vpc_id      = "${aws_vpc.main.id}"
}

resource "aws_security_group" "secgroup_db" {
  name        = "Database Servers"
  description = "Database servers security group"
  vpc_id      = "${aws_vpc.main.id}"
}


resource "aws_security_group_rule" "allow_all_to_elb" {
  description = "Allow all traffic to ELB port 80"
  type            = "ingress"
  from_port       = 80
  to_port         = 80
  protocol        = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb-securitygroup.id}"
}

resource "aws_security_group_rule" "allow_web_to_any" {
  description = "Allow all traffic from WEB to ANY"
  from_port       = 0
  to_port         = 65535
  type            = "egress"
  protocol        = "-1"
  cidr_blocks     = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.secgroup_web.id}"
}


resource "aws_security_group_rule" "allow_any_to_web_ssh" {
  description = "Allow ANY to WEB port 22"
  type            = "ingress"
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.secgroup_web.id}"
}

resource "aws_security_group_rule" "allow_elb_to_web" {
  description = "Allow ELB to WEB port 80"
  type            = "ingress"
  from_port       = 80
  to_port         = 80
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.elb-securitygroup.id}" 
  security_group_id = "${aws_security_group.secgroup_web.id}"
}

resource "aws_security_group_rule" "allow_web_to_app" {
  description = "Allow WEB to APP port 8080"
  type            = "ingress"
  from_port       = 8080
  to_port         = 8080
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.secgroup_web.id}" 
  security_group_id = "${aws_security_group.secgroup_app.id}"
}

resource "aws_security_group_rule" "allow_app_to_db" {
  description = "Allow APP to DB port 3306"
  type            = "ingress"
  from_port       = 3306
  to_port         = 3306
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.secgroup_app.id}" 
  security_group_id = "${aws_security_group.secgroup_db.id}"
}


