data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "task_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}


module "iam" {
  source = "./iam-module"
  custom_policies = {
    deploy-s3-policy = {
      policy_name = "pipeline-deploy-s3"
      path        = "/"
      policy      = templatefile("./policies/deploy-s3-policy.json", { account_id = data.aws_caller_identity.current.account_id, region = data.aws_region.current.name, tfstate_bucketname = "terraform" })
      description = "s3 access"
    }
    deploy-ec2-policy = {
      policy_name = "pipeline-deploy-ec2"
      path        = "/"
      policy      = templatefile("./policies/deploy-ec2-policy.json", { account_id = data.aws_caller_identity.current.account_id, region = data.aws_region.current.name })
      description = "ec2 access"
    }
  }
  account_alias      = "dwp"
  application        = "adobe"
  role_name          = "pipeline-deploy-s3"
  assume_role_policy = data.aws_iam_policy_document.task_assume.json
  create_instance_profile = true
}

output "policy_name" {
  value       = module.iam.iam_policy_names
  description = "Name of the IAM policies"
}

output "policy_arn" {
  value       = module.iam.iam_policy_arns
  description = "ARN of the IAM policies"
}

output "role_name" {
  value       = module.iam.iam_role_name
  description = "Name of the IAM Role"
}

output "role_arn" {
  value       = module.iam.iam_role_arn
  description = "ARN of the IAM Role"
}
