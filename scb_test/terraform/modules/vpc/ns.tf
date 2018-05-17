resource "aws_route53_zone" "example" {
  name   = "example.com"
  vpc_id = "${aws_vpc.main.id}"
}
