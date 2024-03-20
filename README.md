# aws-modules-template
Template for aws modules

# Documentation
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0, < 1.6.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_ami.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_iam_role.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |
| [aws_security_group.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnet.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_vpc.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_ami_name"></a> [aws\_ami\_name](#input\_aws\_ami\_name) | Specify the name of the AMI image to use for the EC2 instance<br>    Valid Values: Any string<br>    Notes: The value will be used to search for AMI by name. | `string` | `"al2023-ami-2023.*-x86_64"` | no |
| <a name="input_aws_security_group_name"></a> [aws\_security\_group\_name](#input\_aws\_security\_group\_name) | Specify the name of the security group to use for the EC2 instance<br>    Valid Values: Any string<br>    Notes: The value will be used to search for the security group by "name". | `string` | `"ssm-tunnel"` | no |
| <a name="input_aws_subnet_name"></a> [aws\_subnet\_name](#input\_aws\_subnet\_name) | Specify the name of the subnet to use for the EC2 instance<br>    Valid Values: Any string<br>    Notes: The value will be used to search for the subnet by "name" within the VPC specified by the aws\_vpc\_name variable. | `string` | `"peering-a"` | no |
| <a name="input_aws_vpc_name"></a> [aws\_vpc\_name](#input\_aws\_vpc\_name) | Specify the name of the VPC to use for the EC2 instance<br>    Valid Values: Any string<br>    Notes: The value will be used to search for the VPC in the account by "name". | `string` | `"peering"` | no |
| <a name="input_name"></a> [name](#input\_name) | Specify the name of the EC2 instance<br>    Valid Values: Any string<br>    Notes: The value will be used as the Name tag for the EC2 instance. | `string` | `"ssm-tunnel"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | n/a |
<!-- END_TF_DOCS -->
