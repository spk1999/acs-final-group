
# Module to deploy basic networking 
module "vpc-prod" {
  source              = "../../../modules/aws_network"
  #source              = "git@github.com:Dhansca/aws_network.git"
  env                 = var.env
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  prefix              = var.prefix
  default_tags        = var.default_tags
  az_count            = var.az_count
  availability_zone_names= var.availability_zone_names
  
}







