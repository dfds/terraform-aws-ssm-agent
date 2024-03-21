locals {
  aws_ami_name             = "al2023-ami-2023.*-x86_64"
  aws_vpc_name             = "peering"
  aws_subnet_name          = "peering-a"
  aws_security_group_name  = "ssm-tunnel"
  aws_iam_instance_profile = "ssm-tunnel"
}
