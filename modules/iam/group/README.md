# IAM Group Module

This Terraform module creates an AWS IAM group with configurable permissions.

## Features

- Creates an IAM group
- Attaches AWS managed policies (by ARN)
- Attaches custom inline policies
- Optional IAM self-management policy (password changes, MFA management)
- Configurable path and tags

## Usage

```hcl
module "developers_group" {
  source = "../../modules/iam/group"

  name = "developers"
  path = "/engineering/"

  # Attach AWS managed policies
  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSCodeCommitPowerUser"
  ]

  # Attach custom inline policies
  custom_group_policies = [
    {
      name = "CustomS3Policy"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "s3:ListBucket",
              "s3:GetObject"
            ]
            Resource = [
              "arn:aws:s3:::my-bucket",
              "arn:aws:s3:::my-bucket/*"
            ]
          }
        ]
      })
    }
  ]

  # Enable self-management (password, MFA)
  attach_iam_self_management_policy = true

  tags = {
    Environment = "production"
    Team        = "engineering"
    ManagedBy   = "terraform"
  }
}
```

## Inputs

| Name                              | Description                            | Type           | Default             | Required |
| --------------------------------- | -------------------------------------- | -------------- | ------------------- | -------- |
| name                              | Name of the IAM group                  | `string`       | -                   | yes      |
| path                              | Path in which to create the group      | `string`       | `/`                 | no       |
| custom_group_policy_arns          | List of ARNs of IAM policies to attach | `list(string)` | `[]`                | no       |
| custom_group_policies             | List of inline IAM policies            | `list(object)` | `[]`                | no       |
| attach_iam_self_management_policy | Attach IAM self-management policy      | `bool`         | `true`              | no       |
| iam_self_management_policy_name   | Name of the self-management policy     | `string`       | `IAMSelfManagement` | no       |
| tags                              | Map of tags to add to resources        | `map(string)`  | `{}`                | no       |

## Outputs

| Name            | Description         |
| --------------- | ------------------- |
| group_name      | IAM group name      |
| group_id        | IAM group ID        |
| group_arn       | IAM group ARN       |
| group_unique_id | IAM group unique ID |

## Self-Management Policy

When enabled, the self-management policy allows IAM users in the group to:

- Change their own password
- Update their login profile
- Manage their own MFA devices
- Enforces MFA requirement for all actions except MFA setup

## Examples

See the `examples/iam/create_group.tf` file for a complete example.
