output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "securitygroup_web" {
  value = "${aws_security_group.secgroup_web.id}"
}

output "securitygroup_app" {
  value = "${aws_security_group.secgroup_app.id}"
}

output "securitygroup_db" {
  value = "${aws_security_group.secgroup_db.id}"
}

output "subnet_id_private" {
  value = "${aws_subnet.private.*.id}"
}

output "subnet_id_public" {
  value = "${aws_subnet.public.*.id}"
}

output "subnet_id_database" {
  value = "${aws_subnet.database.*.id}"
}

output "zone_id" {
  value = "${aws_route53_zone.example.zone_id}"
}

output "aws_elb_id" {
  value = "${aws_elb.my-elb.id}"
}

output "aws_elb_dns_name" {
  value = "${aws_elb.my-elb.dns_name}"
}


