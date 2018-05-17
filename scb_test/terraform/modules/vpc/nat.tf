resource "aws_eip" "nat" {
  vpc   = true
  count = "${length(var.public_subnets)}"
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
  depends_on    = ["aws_internet_gateway.gw"]
  count         = "${length(var.public_subnets)}"
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${element(aws_nat_gateway.nat-gw.*.id, count.index)}"
  }

  tags {
    Name = "private"
  }

  count = "${length(var.public_subnets)}"
}

resource "aws_route_table" "database" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${element(aws_nat_gateway.nat-gw.*.id, count.index)}"
  }

  tags {
    Name = "database"
  }

  count = "${length(var.public_subnets)}"
}

resource "aws_route_table_association" "private-a" {
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
  count          = "${length(var.private_subnets)}"
}

resource "aws_route_table_association" "database-a" {
  subnet_id      = "${element(aws_subnet.database.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.database.*.id, count.index)}"
  count          = "${length(var.database_subnets)}"
}
