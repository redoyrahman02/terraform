resource "aws_iam_user" "this" {
  count         = var.create_user ? 1 : 0
  name          = var.name
  path          = var.path
  force_destroy = var.force_destroy
  tags          = var.tags
}

resource "aws_iam_user_login_profile" "this" {
  count                   = var.create_user && var.create_iam_user_login_profile ? 1 : 0
  user                    = aws_iam_user.this[0].name
  pgp_key                 = var.pgp_key
  password_reset_required = var.password_reset_required
  password_length         = var.password_length
}

resource "aws_iam_access_key" "this" {
  count   = var.create_user && var.create_iam_access_key ? 1 : 0
  user    = aws_iam_user.this[0].name
  pgp_key = var.pgp_key
}

resource "aws_iam_user_policy_attachment" "this" {
  count      = var.create_user ? length(var.policy_arns) : 0
  user       = aws_iam_user.this[0].name
  policy_arn = var.policy_arns[count.index]
}

resource "aws_iam_user_group_membership" "this" {
  count  = var.create_user && length(var.groups) > 0 ? 1 : 0
  user   = aws_iam_user.this[0].name
  groups = var.groups
}
