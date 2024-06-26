data "aws_ami" "this" { # AMI image: Amazon Linux 2023 (free tier eligible)
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = [var.aws_ami_name]
  }
}

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.aws_vpc_name]
  }
}

data "aws_subnet" "selected" {
  vpc_id = data.aws_vpc.selected.id
  filter {
    name   = "tag:Name"
    values = [var.aws_subnet_name]
  }
}

data "aws_security_group" "selected" {
  name = var.aws_security_group_name
}

data "aws_region" "current" {}
