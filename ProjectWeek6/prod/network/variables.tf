variable "default_tags" {
  default = {
    "Owner" = "Sunil"
    "App"   = "Web"
  }
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}

# Needs editing
variable "prefix" {
  default     = "week6"
  type        = string
  description = "Name prefix"
}


# VPC CIDR range
variable "vpc_cidr" {
  default     = "192.168.0.0/16"
  type        = string
  description = "VPC to host static web site"
}

# Provision public subnets in custom VPC
variable "public_subnet_cidrs" {
  default     = ["192.168.1.0/24", "192.168.2.0/24"]
  type        = list(string)
  description = "Public Subnet CIDRs"
}

variable "env" {
  default     = "prod"
  type        = string
  description = "Deployment Environment"
}


variable "az_count" {
  description = "number of active availability zones in VPC"
  default     = "2"
}


variable "availability_zone_names" {
    default     = ["us-east-1a", "us-east-1b"]
    description = "availability zone names"
    type = list(string)
}