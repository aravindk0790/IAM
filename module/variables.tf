variable "custom_policies" {
  type = map(object({
    policy_name = string
    path        = string
    description = string
    policy      = string
  }))
  default = {
    policy_name = null
    path        = null
    description = null
    policy      = null
  }
}

variable "account_alias" {
  description = "AWS Account alias"
  type        = string
  default     = null
}

variable "application" {
  description = "Name of the application"
  type        = string
  default     = null
}

variable "role_name" {
  description = "Name of the IAM Role"
  type        = string
  default     = null
}

variable "assume_role_policy" {
  description = "Statement of the assume role policy"
  type        = string
  default     = null
}

variable "instance_profile_name" {
  description = "Name of the IAM Instance profile"
  type        = string
  default     = null
}

variable "create_instance_profile" {
  description = "Bool to create IAM Instance profile"
  type        = string
  default     = false
}
