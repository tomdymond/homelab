resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "gw"
  }
}

# route tables
resource "aws_route_table" "rt-public" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "public"
  }
}

# route associations public
resource "aws_route_table_association" "rta-public-a" {
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.rt-public.id}"
  count          = "${length(var.public_subnets)}"
}
