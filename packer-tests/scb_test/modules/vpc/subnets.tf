resource "aws_subnet" "private" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${var.private_subnets[count.index]}"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.azs[count.index]}"

  tags {
    Name = "private-${count.index}"
  }

  count = "${length(var.private_subnets)}"
}

resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${var.public_subnets[count.index]}"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.azs[count.index]}"

  tags {
    Name = "public-${count.index}"
  }

  count = "${length(var.public_subnets)}"
}

resource "aws_subnet" "database" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${var.database_subnets[count.index]}"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.azs[count.index]}"

  tags {
    Name = "database-${count.index}"
  }

  count = "${length(var.database_subnets)}"
}
