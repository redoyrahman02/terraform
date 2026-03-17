output "group_name" {
  description = "IAM group name"
  value       = aws_iam_group.this.name
}

output "group_id" {
  description = "IAM group ID"
  value       = aws_iam_group.this.id
}

output "group_arn" {
  description = "IAM group ARN"
  value       = aws_iam_group.this.arn
}

output "group_unique_id" {
  description = "IAM group unique ID"
  value       = aws_iam_group.this.unique_id
}
