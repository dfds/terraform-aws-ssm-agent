provider "aws" {
  region = local.region
}

locals {
  region = "eu-west-1"
}

module "ssm_agent_test" {
  source = "../"

  wakeup_schedule              = "cron(0 7 ? * MON-FRI *)"
  sleep_schedule               = "cron(0 17 ? * MON-FRI *)"
  resource_owner_contact_email = "test@test.com"
  cost_centre                  = "123456"
  service_availability         = "low"
  environment                  = "dev"
}
