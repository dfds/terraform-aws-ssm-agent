locals {
  resource_owner_contact_email = var.resource_owner_contact_email != null ? {
    "dfds.owner" = var.resource_owner_contact_email
  } : {}
  automation_initiator_pipeline_tag = var.pipeline_location != null ? { "dfds.automation.initiator.pipeline" : var.pipeline_location } : {}
  all_tags = merge({
    "dfds.env" : var.environment,
    "dfds.cost.centre" : var.cost_centre,
    "dfds.service.availability" : var.service_availability,
    "dfds.library.name" : "blueprints",
    "dfds.automation.tool" : "Terraform",
    "dfds.automation.initiator.location" : var.automation_initiator_location,
    Name = var.name
  }, var.optional_tags, local.resource_owner_contact_email, local.automation_initiator_pipeline_tag)

  connection_command = "aws ssm start-session --region ${data.aws_region.current.name} --target ${aws_instance.this.id} --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters host='<your_database_endpoint>',portNumber='5432',localPortNumber='5432' --profile saml"
}
