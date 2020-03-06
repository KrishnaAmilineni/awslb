variable "name" {
  type        = string
  description = "load balancer name"
}

variable "internal" {
  type        = bool
  default     = true
  description = "Sets the LB to external or internal"
}

variable "load_balancer_type" {
  type        = string
  description = "Whether it is an application or network load balancer"
  default     = "network"
}

variable "security_groups" {
  type        = list(string)
  description = "IDs of security groups for Load Balancer"
  default     = []
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnets" {
  type        = list(string)
  description = "List of Subnet IDs for the Load Balancer"
}

variable "enable_deletion_protection" {
  type        = bool
  description = "Toggle the deletion protection on the Load Balancer"
  default     = false
}

variable "enable_cross_zone_load_balancing" {
  type        = bool
  description = "Allows the LB to send requests to multiple AZ's based on availability. NLB only"
  default     = true
}

variable "tags" {
  type        = map(any)
  description = "Tags to be applied to resources"
  default     = {}
}

variable "listner_configuration" {
  type        = list(map(any))
  description = "Load Balancer listener configuration"
  default     = []
}

variable "targets" {
  type        = list(map(any))
  description = "Mapping of ec2 instance ids to target_group indecies"
  default     = []
}
