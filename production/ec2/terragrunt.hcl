# Remote Module
terraform {
  source = "git::github.com/cloudacademy/terraform-aws-calabmodules.git//ec2?ref=0.0.3"
}

# Local Module Dependencies
dependency "vpc" {
  config_path = "../vpc"
}

dependency "network" {
  config_path = "../network"
}

# Local Environment Variables
locals {
  env_vars = yamldecode(file(find_in_parent_folders("environment_vars.yaml")))
}

# Include Parent Terragrunt Configuration
include {
  path = find_in_parent_folders()
}

# Specific Module Input Variables
inputs = {
  name = local.env_vars.servername
  vpc_sg = dependency.vpc.outputs.vpc_sg
  subnet_id = dependency.network.outputs.subnet_id
  num_nodes = local.env_vars.nodes
  tags = {
      Environment = local.env_vars.environment
  }

}