# Create IAM Group
resource "aws_iam_group" "this" {
  name = var.name
  path = var.path
}

# Attach AWS managed policies to the group
resource "aws_iam_group_policy_attachment" "custom_arns" {
  count = length(var.custom_group_policy_arns)

  group      = aws_iam_group.this.name
  policy_arn = var.custom_group_policy_arns[count.index]
}

# Attach inline policies to the group
resource "aws_iam_group_policy" "custom" {
  count = length(var.custom_group_policies)

  name   = var.custom_group_policies[count.index].name
  group  = aws_iam_group.this.name
  policy = var.custom_group_policies[count.index].policy
}

# Self Management Policy
data "aws_iam_policy_document" "iam_self_management" {
  count = var.attach_iam_self_management_policy ? 1 : 0

  statement {
    sid = "AllowSelfManagement"
    actions = [
      "iam:ChangePassword",
      "iam:GetUser",
      "iam:GetLoginProfile",
      "iam:UpdateLoginProfile",
    ]
    resources = [
      "arn:aws:iam::*:user/$${aws:username}"
    ]
  }

  statement {
    sid = "AllowListActions"
    actions = [
      "iam:ListUsers",
      "iam:ListVirtualMFADevices",
    ]
    resources = ["*"]
  }

  statement {
    sid = "AllowManageMFA"
    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:ListMFADevices",
      "iam:ResyncMFADevice",
    ]
    resources = [
      "arn:aws:iam::*:user/$${aws:username}",
      "arn:aws:iam::*:mfa/$${aws:username}"
    ]
  }

  statement {
    sid = "DenyAllExceptListedIfNoMFA"
    effect = "Deny"
    not_actions = [
      "iam:CreateVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:GetUser",
      "iam:ListMFADevices",
      "iam:ListVirtualMFADevices",
      "iam:ResyncMFADevice",
    ]
    resources = ["*"]
    condition {
      test     = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["false"]
    }
  }
}

resource "aws_iam_group_policy" "iam_self_management" {
  count = var.attach_iam_self_management_policy ? 1 : 0

  name   = var.iam_self_management_policy_name
  group  = aws_iam_group.this.name
  policy = data.aws_iam_policy_document.iam_self_management[0].json
}
