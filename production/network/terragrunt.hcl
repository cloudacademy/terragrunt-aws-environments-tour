terraform {
  source = "git::github.com/cloudacademy/terraform-aws-calabmodules.git//network?ref=v0.0.1"
}

dependency "vpc" {
  config_path = "../vpc"
}

locals {
  env_vars = yamldecode(file(find_in_parent_folders("environment_vars.yaml")))
}

include {
  path = find_in_parent_folders()
}

inputs = {
  cidr_block = local.env_vars.subnet_cidr
  availability_zone = local.env_vars.availability_zone
  vpc_id = dependency.vpc.outputs.vpc_id
  tags = {
      Environment = local.env_vars.environment
  }
}