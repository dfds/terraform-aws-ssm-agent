# terraform {
#   backend "s3" {}
# }


resource "aws_instance" "this" {
  ami                  = data.aws_ami.this.id
  instance_type        = "t3.micro"
  subnet_id            = data.aws_subnet.selected.id
  iam_instance_profile = "ssm-tunnel"
  tags = {
    Name = var.name
  }
}
