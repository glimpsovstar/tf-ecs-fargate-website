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
  # Instead of using the Terraform Cloud role, use AWS managed role
  #execution_role_arn = "arn:aws:iam::521614675974:role/ecsTaskExecutionRole"
  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  # Remote state references
  vpc_id            = data.terraform_remote_state.network.outputs.vpc_id
  subnet_ids        = data.terraform_remote_state.network.outputs.vpc_public_subnets
  security_group_id = data.terraform_remote_state.network.outputs.security_group-ssh_http_https_allowed
  #execution_role_arn = data.terraform_remote_state.aws_role.outputs.role_arn
}