
# Module to deploy basic networking 
module "vpc-dev" {
 
  source              = "../../../modules/aws_network"
  #source              = "git@github.com:lnxtha/aws_network.git"
  env                 = var.env
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  prefix              = var.prefix
  default_tags        = var.default_tags
  availability_zone_names= var.availability_zone_names
  
}







