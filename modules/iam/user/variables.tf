variable "create_user" {
  description = "Whether to create the IAM user"
  type        = bool
  default     = true
}

variable "name" {
  description = "Desired name for the IAM user"
  type        = string
}

variable "path" {
  description = "Desired path for the IAM user"
  type        = string
  default     = "/"
}

variable "force_destroy" {
  description = "When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "create_iam_user_login_profile" {
  description = "Whether to create IAM user login profile"
  type        = bool
  default     = true
}

variable "pgp_key" {
  description = "Either a base-64 encoded PGP public key, or a keybase username in the form keybase:user"
  type        = string
  default     = ""
}

variable "password_reset_required" {
  description = "Whether the user should be forced to reset the generated password on resource creation"
  type        = bool
  default     = true
}

variable "password_length" {
  description = "The length of the generated password"
  type        = number
  default     = 20
}

variable "create_iam_access_key" {
  description = "Whether to create IAM access key"
  type        = bool
  default     = true
}

variable "policy_arns" {
  description = "List of ARNs of policies to attach to the user"
  type        = list(string)
  default     = []
}

variable "groups" {
  description = "List of IAM user groups to attach to the user"
  type        = list(string)
  default     = []
}
