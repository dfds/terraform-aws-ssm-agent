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
| [aws_iam_role.scheduler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_scheduler_schedule.start_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/scheduler_schedule) | resource |
| [aws_scheduler_schedule.stop_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/scheduler_schedule) | resource |
| [aws_scheduler_schedule_group.schedule_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/scheduler_schedule_group) | resource |
| [aws_ami.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_security_group.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnet.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_vpc.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_automation_initiator_location"></a> [automation\_initiator\_location](#input\_automation\_initiator\_location) | Specify the URL to the repo of automation script.<br>    Valid Values: URL to repo. Example: `"https://github.com/dfds/terraform-aws-rds"`<br>    Notes: This set the dfds.automation.initiator.location tag. See recommendations [here](https://wiki.dfds.cloud/en/playbooks/standards/tagging_policy). | `string` | `null` | no |
| <a name="input_cost_centre"></a> [cost\_centre](#input\_cost\_centre) | Provide a cost centre for the resource.<br>    Valid Values: .<br>    Notes: This set the dfds.cost\_centre tag. See recommendations [here](https://wiki.dfds.cloud/en/playbooks/standards/tagging_policy). | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Specify the staging environment.<br>    Valid Values: "dev", "test", "staging", "uat", "training", "prod".<br>    Notes: The value will set configuration defaults according to DFDS policies. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Specify the name of the EC2 instance<br>    Valid Values: Any string<br>    Notes: The value will be used as the Name tag for the EC2 instance. | `string` | `"ssm-tunnel"` | no |
| <a name="input_optional_tags"></a> [optional\_tags](#input\_optional\_tags) | Provide list of optional dfds.* tags to be applied on all resources.<br>    Valid Values: .<br>    Notes:<br>    - Use this only for optional tags. Required tags are supplied through dedicated variables.<br>    - See recommendations [here](https://wiki.dfds.cloud/en/playbooks/standards/tagging_policy). | `map(string)` | `{}` | no |
| <a name="input_pipeline_location"></a> [pipeline\_location](#input\_pipeline\_location) | Specify a valid URL path to the pipeline file used for automation script.<br>    Valid Values: URL to repo. Example: `"https://github.com/dfds/terraform-aws-rds/actions/workflows/qa.yml"`<br>    Notes: This set the dfds.automation.initiator.pipeline tag. See recommendations [here](https://wiki.dfds.cloud/en/playbooks/standards/tagging_policy). | `string` | `null` | no |
| <a name="input_resource_owner_contact_email"></a> [resource\_owner\_contact\_email](#input\_resource\_owner\_contact\_email) | Provide an email address for the resource owner (e.g. team or individual).<br>    Valid Values: .<br>    Notes: This set the dfds.owner tag. See recommendations [here](https://wiki.dfds.cloud/en/playbooks/standards/tagging_policy). | `string` | `null` | no |
| <a name="input_service_availability"></a> [service\_availability](#input\_service\_availability) | Specify service availability.<br>    Valid Values: low, medium, high<br>    Notes: This set the dfds.service.availability tag. See recommendations [here](https://wiki.dfds.cloud/en/playbooks/standards/tagging_policy). | `string` | n/a | yes |
| <a name="input_sleep_schedule"></a> [sleep\_schedule](#input\_sleep\_schedule) | Specify the cron expression for the sleep schedule<br>    Valid Values: Any valid cron expression<br>    Notes: The cron expression will be used to stop the EC2 instance running the SSM agent | `string` | `"cron(0 18 ? * MON-FRI *)"` | no |
| <a name="input_sleep_schedule_is_enabled"></a> [sleep\_schedule\_is\_enabled](#input\_sleep\_schedule\_is\_enabled) | Enable or disable the sleep schedule.<br>    Valid Values: true, false<br>    Notes:<br>    - If set to true, the wakeup and sleep schedule will take effect based on be enabled schedules specified in wakeup\_schedule and sleep\_schedule variables.<br>    - If set to false, the EC2 instance will be running 24/7. | `bool` | `true` | no |
| <a name="input_wakeup_schedule"></a> [wakeup\_schedule](#input\_wakeup\_schedule) | Specify the cron expression for the wakeup schedule<br>    Valid Values: Any valid cron expression<br>    Notes: The cron expression will be used to start the EC2 instance running the SSM agent | `string` | `"cron(0 8 ? * MON-FRI *)"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_command"></a> [connection\_command](#output\_connection\_command) | n/a |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | n/a |
<!-- END_TF_DOCS -->
