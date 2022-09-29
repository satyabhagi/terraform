terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  region = "ap-south-1"
}
locals {
  name_test = "prj"
}

resource "aws_vpc" "tvpc" {
    cidr_block = "172.2.0.0/16"

    tags = {
        Name = "${local.name_test}_vpc"
    }
}

resource "aws_subnet" "web" {
    vpc_id = aws_vpc.tvpc.id
    cidr_block = "172.2.0.0/16"

    tags = {
        Name = "${local.name_test}_subnet"
    }
}
resource "aws_instance" "test" {
    ami           = "ami-05c8ca4485f8b138a"
    instance_type = var.my_instance_type
    subnet_id = aws_subnet.web.id

    tags = var.instance_tags
}
output "instance_ip" {
  value = aws_instance.test.public_ip
}