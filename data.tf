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

data "aws_security_group" "selected" {
  filter {
    name   = "tag:Name"
    values = ["ssm-tunnel"]
  }
}

data "aws_iam_role" "selected" {
  name = "ssm-tunnel"
}
