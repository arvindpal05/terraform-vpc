variable "region" {
  description = "Region where to want to create VPC"
}
variable "vpc_cdir" {
  default ="10.0.0.0/16"
}
variable "vpc_name" {
  default = "arvindvpc"
}
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cdir
  tags = {
    "Name" = var.vpc_name
  }
}

data "aws_availability_zones" "azs" {
  
}
resource "aws_subnet" "subnet" {
  count = length(data.aws_availability_zones.azs.names)
  cidr_block = "10.0.${count.index+1 }.0/24"
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "${var.vpc_name}_Private-10.0.${count.index+1 }.0/24"
  }
}

