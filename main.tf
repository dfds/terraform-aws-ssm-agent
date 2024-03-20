# terraform {
#   backend "s3" {}
# }


resource "aws_instance" "this" {
  ami                  = data.aws_ami.this.id
  instance_type        = "t3.micro"
  subnet_id            = data.aws_subnet.selected.id
  iam_instance_profile = data.aws_iam_role.selected.name
  tags = {
    Name = "ssm-tunnel"
  }
}


#TODO:
# Auto-assign public IP: disable
#Security group: Select existing security group (ssm-tunnel)
#Expand advanced details and select the following:
#IAM Instance Profile: ssm-tunnel
