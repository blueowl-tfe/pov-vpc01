output "region" {
  value = "${var.aws_region}"
}

output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "subnet-public-1_id" {
  value = "${aws_subnet.subnet-public-1.id}"
}

output "subnet-public-2_id" {
  value = "${aws_subnet.subnet-public-2.id}"
}

output "subnet-public-3_id" {
  value = "${aws_subnet.subnet-public-3.id}"
}

output "sg" {
  value = "${aws_security_group.sg.id}"  
}
