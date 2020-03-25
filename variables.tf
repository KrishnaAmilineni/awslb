variable "name" {
  type        = string
  description = "load balancer name"
}

variable "internal" {
  type        = bool
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

variable "zone_name" {
  type        = string
  description = "Route53 Zone Name"
  default     = ""
}

variable "alias" {
  type        = list(string)
  description = "Route53 alias"
  default     = []
}


variable "create_alarm" {
  type        = bool
  description = "Create CW Alarm"
  default     = true
}

variable "alarm_sns" {
  type        = string
  description = "CW Alarm SNS"
  default     = ""
}
