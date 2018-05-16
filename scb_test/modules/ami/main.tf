module globals {
  source = "../globals"
}

data "template_file" "init" {
  template = "${file("${path.module}/user_data_${var.node_role}")}"

  vars {
    node_role         = "${var.node_role}"
    database_servers  = "db.az0.example.com"
    database_password = "${var.database_password}"
    az_id             = "${count.index}"
  }

  count = "${length(var.azs)}"
}

resource "aws_instance" "host" {
  ami               = "${module.globals.amis[var.node_role]}"
  availability_zone = "${var.azs[count.index]}"
  instance_type     = "${module.globals.instance_types[var.node_role]}"
  key_name          = "${module.globals.key_name}"

  tags {
    Name = "${var.instance_tags}"
  }

  vpc_security_group_ids = ["${var.securitygroup}"]
  subnet_id              = "${element(var.subnetid, count.index)}"
  user_data              = "${element(data.template_file.init.*.rendered, count.index)}"
  count                  = "${length(var.azs)}"
}

resource "aws_route53_record" "server-record" {
  zone_id = "${var.zone_id}"
  name    = "${var.node_role}.az${count.index}.example.com"
  type    = "A"
  ttl     = "60"
  records = ["${element(aws_instance.host.*.private_ip, count.index)}"]
  count   = "${length(var.azs)}"
}



