#VPC//------------------------------------------------------------------------- 

provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_vpc" "vpc" {
    cidr_block = "11.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags {
        Name = "vinnievpcTEST"
    }
}


# Subnets
resource "aws_subnet" "subnet-public-1" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "11.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"

    tags {
        Name = "vinnie-public-1"
    }
}
resource "aws_subnet" "subnet-public-2" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "11.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1b"

    tags {
        Name = "vinnie-public-2"
    }
}
resource "aws_subnet" "subnet-public-3" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "11.0.3.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1c"

    tags {
        Name = "vinnie-public-3"
    }
}
resource "aws_subnet" "subnet-private-1" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "11.0.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1a"

    tags {
        Name = "vinnie-private-1"
    }
}
resource "aws_subnet" "subnet-private-2" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "11.0.5.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1b"

    tags {
        Name = "vinnie-private-2"
    }
}
resource "aws_subnet" "subnet-private-3" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "11.0.6.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1c"

    tags {
        Name = "vinnie-private-3"
    }
}

# Internet GW
resource "aws_internet_gateway" "internet-gw" {
    vpc_id = "${aws_vpc.vpc.id}"

    tags {
        Name = "vinnie-gw"
    }
}

# route tables
resource "aws_route_table" "subnet-public" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.internet-gw.id}"
    }

    tags {
        Name = "vinnie-public-1"
    }
}

# route associations public
resource "aws_route_table_association" "subnet-public-1-a" {
    subnet_id = "${aws_subnet.subnet-public-1.id}"
    route_table_id = "${aws_route_table.subnet-public.id}"
}
resource "aws_route_table_association" "subnet-public-2-a" {
    subnet_id = "${aws_subnet.subnet-public-2.id}"
    route_table_id = "${aws_route_table.subnet-public.id}"
}
resource "aws_route_table_association" "subnet-public-3-a" {
    subnet_id = "${aws_subnet.subnet-public-3.id}"
    route_table_id = "${aws_route_table.subnet-public.id}"
}

#SECURITY GROUP(s)//-----------------------------------------------------------  

resource "aws_security_group" "sg" {
  vpc_id = "${aws_vpc.vpc.id}"
  name = "vinnie-sgtest"
  description = "security group that allows ssh and all egress traffic"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"] 
 }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["${var.my_ip}"]
 }
}
