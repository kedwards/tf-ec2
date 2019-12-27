#
# required
#
variable "ami" {
  description = "The ami to use for the instance."
  type        = string
}

variable "launch_name_prefix" {
  description = "The launch config name-prefix, Terraform will add a random string at the end to keep it unique."
  type        = string
}

variable "protocol" {
  default     = "HTTP"
  description = "Protocol used to communicate with target group."
  type        = string
}

variable "provisioning_key" {
  description = "A key that can be used to connect and provision instances in AWS."
  type        = string
}

variable "vpc_id" {
  description = "The vpc to deploy resources into."
  type        = string
}

variable "vpc_zone_identifier" {
  description = "The subnets to place the instance."
  type        = list(string)
}

#
# optional
#
variable "alb_security_groups" {
  default     = []
  description = "The list of security groups to attach with the load balancer."
  type        = list(string)
}

variable "alb_tags" {
  default     = {}
  description = "Additional tags for the alb"
  type        = map(string)
}

variable "associate_public_ip_address" {
  default     = true
  description = "Associate a public IP addrss on launch."
  type        = bool
}

variable "create_alb" {
  default     = false
  description = "Whether to create an ALB."
  type        = bool
}

variable "create_key_pair" {
  default     = false
  description = "Whether to create a key pair."
  type        = bool
}

variable "desired_capacity" {
  default     = 1
  description = "The desired number of instances to run."
  type        = number
}

variable "enable_monitoring" {
  default     = false
  description = "Enable monitoring of the instance."
  type        = bool
}

variable "health_check_type" {
  default     = "EC2"
  description = "The type of health check to configure. 'EC2' or 'ELB'"
  type        = string
}

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

variable "internal_lb" {
  default     = false
  description = "Whether to create an internal load balancer."
  type        = bool
}

variable "load_balancer_type" {
  default     = "application"
  description = "Type of load balancer"
  type        = string
}

variable "max_size" {
  default     = 1
  description = "The maximum number of instances."
  type        = number
}

variable "min_size" {
  default     = 0
  description = "The minimum number of instances."
  type        = number
}

variable "name" {
  default     = "instance"
  description = "The name of the instance."
  type        = string
}

variable "path" {
  default     = "/"
  description = "The alb health check path."
  type        = string
}

variable "public_key" {
  default     = ""
  description = "The publick_key for use with the instance."
  type        = string
}

variable "security_groups" {
  default     = []
  description = "The SGs to access the instance."
  type        = list(string)
}

variable "subnets" {
  default     = []
  description = "The subnets use for the ALB."
  type        = list(string)
}

variable "tags" {
  default     = [{}]
  description = "Additional tags for the instance"
  type        = list(map(string))
}

variable "target_group_port" {
  default     = "80"
  description = "Alb target port."
  type        = string
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
