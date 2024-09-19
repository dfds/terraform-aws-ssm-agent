terraform {
  backend "s3" {}
}

locals {
  regional_postfix = var.regional_postfix ? "-${data.aws_region.current.name}" : ""
}

resource "aws_instance" "this" {
  ami                  = data.aws_ami.this.id
  instance_type        = "t3.micro"
  subnet_id            = data.aws_subnet.selected.id
  iam_instance_profile = "${var.aws_iam_instance_profile}${local.regional_postfix}"
  tags                 = local.all_tags
}
resource "aws_scheduler_schedule_group" "schedule_group" {
  name = var.name
  tags = local.all_tags
}

resource "aws_scheduler_schedule" "start_instance" {
  name       = "${var.name}_start_instance"
  group_name = aws_scheduler_schedule_group.schedule_group.id
  flexible_time_window {
    mode = "OFF"
  }
  description                  = "Start instances event"
  schedule_expression          = var.wakeup_schedule
  schedule_expression_timezone = "UTC"
  target {
    arn      = "arn:aws:scheduler:::aws-sdk:ec2:startInstances"
    role_arn = aws_iam_role.scheduler.arn

    input = jsonencode({
      "InstanceIds" : [
        "${aws_instance.this.id}"
      ]
    })
  }
  state = var.sleep_schedule_is_enabled ? "ENABLED" : "DISABLED"
}
resource "aws_scheduler_schedule" "stop_instance" {
  name                         = "${var.name}_stop_instance"
  group_name                   = aws_scheduler_schedule_group.schedule_group.id
  description                  = "Stop instances event"
  schedule_expression_timezone = "UTC"
  flexible_time_window {
    mode = "OFF"
  }
  schedule_expression = var.sleep_schedule

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:ec2:stopInstances"
    role_arn = aws_iam_role.scheduler.arn

    input = jsonencode({
      InstanceIds = [aws_instance.this.id]
    })
  }
  state = var.sleep_schedule_is_enabled ? "ENABLED" : "DISABLED"
}

resource "aws_iam_role" "scheduler" {
  name = "${var.name}_scheduler${local.regional_postfix}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "scheduler.amazonaws.com",
        },
        Action = "sts:AssumeRole",
      }
    ]
  })

  inline_policy {
    name = "stop_instance"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["ec2:StartInstances", "ec2:StopInstances"]
          Effect   = "Allow"
          Resource = aws_instance.this.arn
        },
      ]
    })
  }
  tags = local.all_tags
}
