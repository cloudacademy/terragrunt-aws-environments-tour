terraform {
  source = "git::github.com/cloudacademy/terraform-aws-calabmodules.git//vpc?ref=v0.0.1"
}

locals {
  env_vars = yamldecode(file(find_in_parent_folders("environment_vars.yaml")))
}

include {
  path = find_in_parent_folders()
}

inputs = {
  cidr_block = local.env_vars.vpc_cidr
  tags = {
      Environment = local.env_vars.environment
  }
}