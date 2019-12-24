#
# required
#
variable "ami" {
  description = "The ami to use for the instance."
  type        = string
}

variable "provisioning_key" {
  description = "A key that can be used to connect and provision instances in AWS."
  type        = string
}

variable "subnet" {
  description = "The subnet to place the instance."
  type        = string
}

#
# optional
#
variable "instance_tags" {
  default     = {}
  description = "Additional tags for the instance"
  type        = map(string)
}

variable "instance_count" {
  default     = 1
  description = "How many instances to create."
  type        = number
}

variable "instance_type" {
  default     = "t2.micro"
  description = "The instance type to use for the instance."
  type        = string
}

variable "name" {
  default     = "instance"
  description = "The name of the instance."
  type        = string
}

variable "security_groups" {
  default     = []
  description = "The SGs to access the instance."
  type        = list(string)
}

variable "tags" {
  default     = {}
  description = "Additional tags for the instance"
  type        = map(string)
}

variable "user_data" {
  default     = ""
  description = "The subnet to place the instance."
  type        = string
}

variable "volume_size" {
  default     = 20
  description = "The volume size to use for the instance (GB)."
  type        = number
}

variable "volume_type" {
  default     = "gp2"
  description = "The volume type to use for data storage on the instance."
  type        = string
}
