variable "default_tags" {
  default = {
    "Owner" = "Sunil"
    "App"   = "Web"
  }
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}


variable "prefix" {
  default     = "week6"
  type        = string
  description = "Name prefix"
}


variable "env" {
  default     = "dev"
  type        = string
  description = "Deployment Environment"
}


variable "instance_type" {
  default = {
    "prod"    = "t3.medium"
    "dev"     = "t3.micro"
    "staging" = "t2.micro"
  }
  description = "Type of the instance"
  type        = map(string)
}

variable "bucket_name" {
  default     = "group-17-s3-bucket1"
  type        = string
  description = "Bucket Name"
}

variable "remote_bucket_key" {
  default     = "dev/01-networking/terraform.tfstate"
  type        = string
  description = "Bucket Name"
}


## Not required as these are pulled from networking remote server
# # VPC CIDR range
# variable "vpc_cidr" {
#   default     = "192.169.0.0/16"
#   type        = string
#   description = "VPC to host static web site"
# }

# # Provision public subnets in custom VPC
# variable "public_subnet_cidrs" {
#   default     = ["192.169.1.0/24", "192.169.2.0/24"]
#   type        = list(string)
#   description = "Public Subnet CIDRs"
# }

# variable "webserver_key_path"{
#   type = string
#   description = "Webserver project path"
# }