variable "default_tags" {
  #default = {}
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}


variable "prefix" {
  #default     = "week6"
  type        = string
  description = "Name prefix"
}


variable "env" {
 # default     = "dev"
  type        = string
  description = "Deployment Environment"
}


variable "instance_type" {
  #default = {}
  description = "Type of the instance"
  type        = map(string)
}


variable "bucket_name"{
  
  type = string
  description = "Bucket Name"
}

variable "remote_bucket_key"{
  
  type = string
  description = "Bucket Name"
}


variable "webserver_project_path"{
  type = string
  description = "Webserver project path"
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

variable "webserver_key_path"{
  type = string
  description = "Webserver project path"
}




# Needs editing
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Availability Zones
data "aws_availability_zones" "available" {
  state = "available"
}

# This block is defined to get terraform state file from dev
data "terraform_remote_state" "public_subnet" {
  backend = "s3"
  config = {
    #bucket = "acs730-week6-sshrestha63"
    bucket = var.bucket_name
    
    #key    = "01-networking/terraform.tfstate"
    key    = var.remote_bucket_key
    
    region = "us-east-1"
  }
}