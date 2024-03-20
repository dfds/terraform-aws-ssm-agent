variable "name" {
  description = <<EOF
    Specify the name of the EC2 instance
    Valid Values: Any string
    Notes: The value will be used as the Name tag for the EC2 instance.
EOF
  type        = string
  default     = "ssm-tunnel"
}

variable "aws_ami_name" {
  description = <<EOF
    Specify the name of the AMI image to use for the EC2 instance
    Valid Values: Any string
    Notes: The value will be used to search for AMI by name.
EOF
  type        = string
  default     = "al2023-ami-2023.*-x86_64"
}

variable "aws_vpc_name" {
  description = <<EOF
    Specify the name of the VPC to use for the EC2 instance
    Valid Values: Any string
    Notes: The value will be used to search for the VPC in the account by "name".
EOF
  type        = string
  default     = "peering"
}

variable "aws_subnet_name" {
  description = <<EOF
    Specify the name of the subnet to use for the EC2 instance
    Valid Values: Any string
    Notes: The value will be used to search for the subnet by "name" within the VPC specified by the aws_vpc_name variable.
EOF
  type        = string
  default     = "peering-a"
}

variable "aws_security_group_name" {
  description = <<EOF
    Specify the name of the security group to use for the EC2 instance
    Valid Values: Any string
    Notes: The value will be used to search for the security group by "name".
EOF
  type        = string
  default     = "ssm-tunnel"
}
