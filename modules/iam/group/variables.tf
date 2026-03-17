variable "name" {
  description = "Name of the IAM group"
  type        = string
}

variable "path" {
  description = "Path in which to create the group"
  type        = string
  default     = "/"
}

variable "custom_group_policy_arns" {
  description = "List of ARNs of IAM policies to attach to the group"
  type        = list(string)
  default     = []
}

variable "custom_group_policies" {
  description = "List of maps of inline IAM policies to put on the group"
  type = list(object({
    name   = string
    policy = string
  }))
  default = []
}

variable "attach_iam_self_management_policy" {
  description = "Whether to attach IAM policy which allows IAM users to manage their credentials and MFA"
  type        = bool
  default     = true
}

variable "iam_self_management_policy_name" {
  description = "The name of the IAM self-management policy"
  type        = string
  default     = "IAMSelfManagement"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
