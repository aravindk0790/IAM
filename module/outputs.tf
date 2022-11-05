output "iam_policy_names" {
  value       = values({ for key, value in aws_iam_policy.policy : key => value.name })
  description = "Name of the policies"
}

output "iam_policy_arns" {
  value       = values({ for key, value in aws_iam_policy.policy : key => value.arn })
  description = "ARN of the policies"
}

output "iam_role_name" {
  value       = aws_iam_role.role.name
  description = "Name of the IAM Role"
}

output "iam_role_arn" {
  value       = aws_iam_role.role.arn
  description = "ARN of the IAM Role"
}
