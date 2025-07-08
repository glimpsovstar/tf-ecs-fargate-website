data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    organization = "djoo-hashicorp"

    workspaces = {
      name = "tf-aws-network-dev"
    }
  }
}

locals {
  vpc_id            = data.terraform_remote_state.network.outputs.vpc_id
  subnet_ids        = data.terraform_remote_state.network.outputs.vpc_public_subnets
  security_group_id = data.terraform_remote_state.network.outputs.security_group-ssh_http_https_allowed

  # Leveraging AWS OIDC variable set
  execution_role_arn = trimspace(env.TFC_AWS_RUN_ROLE_ARN)
}