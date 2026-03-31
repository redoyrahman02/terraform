variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "ami" {
  description = "The AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the instance"
  type        = string
  default     = null
}

variable "iam_instance_profile" {
  description = "IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile"
  type        = string
  default     = null
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with an instance in a VPC"
  type        = bool
  default     = null
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  type        = string
  default     = null
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "create_eip" {
  description = "Whether to create an Elastic IP for the instance"
  type        = bool
  default     = false
}

variable "create_security_group" {
  description = "Whether to create a security group for the instance"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created (required if create_security_group is true)"
  type        = string
  default     = null
}

variable "ingress_ports" {
  description = "List of ingress ports to open in the newly created security group"
  type        = list(number)
  default     = []
}

variable "ingress_cidr_blocks" {
  description = "List of CIDR blocks to allow for the ingress_ports"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
