provider "aws" {
  region = "us-east-1"
}

module "dev_group" {
  source = "../../modules/iam/group"

  name = "dev-group"
  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSCodeCommitPowerUser",
    "arn:aws:iam::aws:policy/AdministratorAccess-Amplify"
  ]
  attach_iam_self_management_policy = false

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}
