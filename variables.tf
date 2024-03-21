variable "name" {
  description = <<EOF
    Specify the name of the EC2 instance
    Valid Values: Any string
    Notes: The value will be used as the Name tag for the EC2 instance.
EOF
  type        = string
  default     = "ssm-tunnel"
}
