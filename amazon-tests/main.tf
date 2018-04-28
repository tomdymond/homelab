variable aws_access_key {}
variable aws_secret_key {}
variable region {
  default = "us-east-1"
}

variable "base_cidr_block" {
  default = "10.0.0.0/12"
}

variable "region_numbers" {
  default = {
    us-east-1 = 1
    us-west-1 = 2
    us-west-2 = 3
    eu-west-1 = 4
  }
}



variable "vpc_id" {
  default = "vpc-6b84d510"
}

#resource "aws_vpc" "main" {
#  cidr_block = "${cidrsubnet(var.base_cidr_block, 4, lookup(var.region_numbers, var.region))}"
#}


#data "aws_vpc" "selected" {
#  id = "${var.vpc_id}"
#}


#resource "aws_subnet" "example" {
#  vpc_id            = "${data.aws_vpc.selected.id}"
#  availability_zone = "us-east-1d"
#  cidr_block        = "${cidrsubnet(data.aws_vpc.selected.cidr_block, 4, 1)}"
#}

# Configure the AWS Provider
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}

# Create a web server
resource "aws_instance" "host" {
  ami = "ami-0cdc2b8a81b45a7b4"
  availability_zone = "us-east-1d"
  instance_type = "t2.micro"
  key_name = "tom-aws-virginia"
  tags {
    Name = "docker01"
  }


  security_groups = [
    "allow_ssh"
  ]
}


