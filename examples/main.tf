provider "aws" {
  region = local.region
}

locals {
  region = "eu-west-1"
}

module "ssm_agent_test" {
  source = "../"

}
