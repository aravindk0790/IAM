resource "aws_iam_policy" "policy" {
  for_each    = var.custom_policies
  name        = "${var.account_alias}-${each.value.policy_name}-${var.application}"
  path        = each.value.path
  description = each.value.description
  policy      = each.value.policy
}

resource "aws_iam_role" "role" {
  name               = "${var.account_alias}-${var.role_name}-${var.application}"
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_role_policy_attachment" "attachment" {
  depends_on = [aws_iam_policy.policy]
  count      = length(local.policy_arn)
  role       = aws_iam_role.role.name
  policy_arn = local.policy_arn[count.index]
}

resource "aws_iam_instance_profile" "profile" {
  count= var.create_instance_profile ? 1 : 0
  name = var.instance_profile_name
  role = aws_iam_role.role.name
}

locals {
  policy_arn = values({ for key, value in aws_iam_policy.policy : key => value.arn })
}
