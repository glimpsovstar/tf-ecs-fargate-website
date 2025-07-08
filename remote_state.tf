data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    organization = "djoo-hashicorp"

    workspaces = {
      name = "tf-aws-network-dev"
    }
  }
}

# AWS IAM role workspace for execution roles
data "terraform_remote_state" "aws_role" {
  backend = "remote"
  
  config = {
    organization = "djoo-hashicorp"
    
    workspaces = {
      name = "aws-openid-role-for-stacks"
    }
  }
}

locals {
  vpc_id            = data.terraform_remote_state.network.outputs.vpc_id
  subnet_ids        = data.terraform_remote_state.network.outputs.vpc_public_subnets
  security_group_id = data.terraform_remote_state.network.outputs.security_group-ssh_http_https_allowed

  # Leveraging AWS OIDC variable set
  execution_role_arn = data.terraform_remote_state.aws_role.outputs.role_arn
}