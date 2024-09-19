variable "name" {
  description = <<EOF
    Specify the name of the EC2 instance
    Valid Values: Any string
    Notes: The value will be used as the Name tag for the EC2 instance.
EOF
  type        = string
  default     = "ssm-tunnel"
}

variable "wakeup_schedule" {
  description = <<EOF
    Specify the cron expression for the wakeup schedule
    Valid Values: Any valid cron expression
    Notes: The cron expression will be used to start the EC2 instance running the SSM agent
EOF
  type        = string
  default     = "cron(0 8 ? * MON-FRI *)"
}

variable "sleep_schedule" {
  description = <<EOF
    Specify the cron expression for the sleep schedule
    Valid Values: Any valid cron expression
    Notes: The cron expression will be used to stop the EC2 instance running the SSM agent
 EOF
  type        = string
  default     = "cron(0 18 ? * MON-FRI *)"
}

variable "sleep_schedule_is_enabled" {
  description = <<EOF
    Enable or disable the sleep schedule.
    Valid Values: true, false
    Notes:
    - If set to true, the wakeup and sleep schedule will take effect based on be enabled schedules specified in wakeup_schedule and sleep_schedule variables.
    - If set to false, the EC2 instance will be running 24/7.
EOF
  type        = bool
  default     = true
}

variable "aws_ami_name" {
  description = <<EOF
    Optional. Specify the name of the AMI image to use for the EC2 instance
    Valid Values: Any suitable EC2 instance filter string
    Notes:
    - The value will be used to filter the AMI image to use for the EC2 instance.
    - If not specified, it will use the default value as a filter.
EOF
  default     = "al2023-ami-2023.*-x86_64"
  type        = string

}

variable "aws_vpc_name" {
  description = <<EOF
    Optional. Specify the name of the VPC to use for the EC2 instance
    Valid Values: Any valid VPC name
    Notes:
    - The value will be used to place the EC2 instance in the correct VPC.
    - If not specified, it will use the default value.
EOF
  default     = "peering"
  type        = string
}

variable "aws_subnet_name" {
  description = <<EOF
    Optional. Specify the name of the subnet to use for the EC2 instance
    Valid Values: Any valid VPC Subnet name
    Notes:
    - The value will be used to place the EC2 instance in the correct subnet.
    - If not specified, it will use the default value.
EOF
  default     = "peering-a"
  type        = string
}

variable "aws_security_group_name" {
  description = <<EOF
    Optional. Specify the name of the security group to use for the EC2 instance
    Valid Values: Any valid AWS Security Group name
    Notes:
    - The value will be used to attach the correct security group to the EC2 instance.
    - If not specified, it will use the default value.
EOF
  default     = "ssm-tunnel"
  type        = string

}

variable "aws_iam_instance_profile" {
  description = <<EOF
    Optional. Specify the name of the IAM instance profile to use for the EC2 instance
    Valid Values: Any valid IAM Instance Profile name
    Notes:
    - The value will be used to set the IAM instance profile for the EC2 instance.
    - If not specified, it will use the default value.
EOF
  default     = "ssm-tunnel"
  type        = string

}


################################################################################
# Resource tagging
################################################################################

variable "resource_owner_contact_email" {
  description = <<EOF
    Provide an email address for the resource owner (e.g. team or individual).
    Valid Values: .
    Notes: This set the dfds.owner tag. See recommendations [here](https://wiki.dfds.cloud/en/playbooks/standards/tagging_policy).
EOF

  type    = string
  default = null
  validation {
    condition     = var.resource_owner_contact_email == null || can(regex("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$", var.resource_owner_contact_email))
    error_message = "Invalid value for var.resource_owner_contact_email. Must be a valid email address."
  }
}

variable "cost_centre" {
  description = <<EOF
    Provide a cost centre for the resource.
    Valid Values: .
    Notes: This set the dfds.cost_centre tag. See recommendations [here](https://wiki.dfds.cloud/en/playbooks/standards/tagging_policy).
EOF
  type        = string
}

variable "service_availability" {
  description = <<EOF
    Specify service availability.
    Valid Values: low, medium, high
    Notes: This set the dfds.service.availability tag. See recommendations [here](https://wiki.dfds.cloud/en/playbooks/standards/tagging_policy).
EOF
  type        = string
  validation {
    condition     = contains(["low", "medium", "high"], var.service_availability)
    error_message = "Invalid value for var.service_availability. Supported values: low, medium, high."
  }
}

variable "optional_tags" {
  description = <<EOF
    Provide list of optional dfds.* tags to be applied on all resources.
    Valid Values: .
    Notes:
    - Use this only for optional tags. Required tags are supplied through dedicated variables.
    - See recommendations [here](https://wiki.dfds.cloud/en/playbooks/standards/tagging_policy).
EOF
  type        = map(string)
  default     = {}
}

variable "pipeline_location" {
  description = <<EOF
    Specify a valid URL path to the pipeline file used for automation script.
    Valid Values: URL to repo. Example: `"https://github.com/dfds/terraform-aws-rds/actions/workflows/qa.yml"`
    Notes: This set the dfds.automation.initiator.pipeline tag. See recommendations [here](https://wiki.dfds.cloud/en/playbooks/standards/tagging_policy).
EOF
  type        = string
  default     = null
  validation {
    condition     = var.pipeline_location == null || can(regex("^(https:\\/\\/www\\.|http:\\/\\/www\\.|https:\\/\\/|http:\\/\\/)?[a-zA-Z0-9]{2,}(\\.[a-zA-Z0-9]{2,})(\\.[a-zA-Z0-9]{2,})?(\\/[a-zA-Z0-9_.:/=+-@][^?|^/&]{2,})+$", var.pipeline_location))
    error_message = "Value for var.pipeline_location contains invalid characters. See AWS [user guide](https://docs.aws.amazon.com/tag-editor/latest/userguide/tagging.html) for more information."
  }
}

variable "automation_initiator_location" {
  description = <<EOF
    Specify the URL to the repo of automation script.
    Valid Values: URL to repo. Example: `"https://github.com/dfds/terraform-aws-rds"`
    Notes: This set the dfds.automation.initiator.location tag. See recommendations [here](https://wiki.dfds.cloud/en/playbooks/standards/tagging_policy).
  EOF
  type        = string
  default     = null
  validation {
    condition     = var.automation_initiator_location == null || can(regex("^(https:\\/\\/www\\.|http:\\/\\/www\\.|https:\\/\\/|http:\\/\\/)?[a-zA-Z0-9]{2,}(\\.[a-zA-Z0-9]{2,})(\\.[a-zA-Z0-9]{2,})?(\\/[a-zA-Z0-9_.:/=+-@][^?|^/&]{2,})+[\\/]?$", var.automation_initiator_location))
    error_message = "Value for var.automation_initiator_location contains invalid characters or URL is malformed. See AWS [user guide](https://docs.aws.amazon.com/tag-editor/latest/userguide/tagging.html) for more information. Example: https://github.com/dfds/terraform-aws-rds"
  }
}

variable "environment" {
  description = <<EOF
    Specify the staging environment.
    Valid Values: "dev", "test", "staging", "uat", "training", "prod".
    Notes: The value will set configuration defaults according to DFDS policies.
EOF
  type        = string
  validation {
    condition     = contains(["dev", "test", "staging", "uat", "training", "prod"], var.environment)
    error_message = "Valid values for environment are: dev, test, staging, uat, training, prod."
  }
}

variable "regional_postfix" {
  description = <<EOF
    Enable region as postfix in resources names where applicable
    Valid Values: true, false
    Notes: If set to true, the region will be added as a postfix to the resource names.
EOF
  type        = bool
  default     = false
}
