terraform {
  backend "s3" {}
}


data "aws_ami" "this" { # AMI image: Amazon Linux 2023 (free tier eligible)
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name" # Amazon Linux 2023 AMI
    values = ["ami-074254c177d57d6404"]
  }
}

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["peering"]
  }
}

data "aws_subnet" "selected" {
  vpc_id = data.aws_vpc.selected.id
  filter {
    name   = "tag:Name"
    values = ["peering-a"]
  }
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.this.id
  instance_type = "t3.micro"
  subnet_id     = data.aws_subnet.selected.id
  tags = {
    Name = "ssm-tunnel"
  }
}

#TODO:
# Auto-assign public IP: disable
#Security group: Select existing security group (ssm-tunnel)
#Expand advanced details and select the following:
#IAM Instance Profile: ssm-tunnel
