terraform {
required_providers {
  aws = {
  source = "hashicorp/aws"
  version = ">= 3.27"
 }
}

  required_version = ">=0.14"
} 


provider "aws" {
  region = "us-east-1"
}

resource "aws_default_vpc" "default_vpc" {
  tags = {
    Name = "Default VPC"
  }
}



################################################################################################################
################################################################################################################
# Create a new VPC 
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = merge(
    local.default_tags, {
      Name = "${var.prefix}-public-vpc-${var.env}"
    }
  )
}



# Create a new Subnet
resource "aws_subnet" "public_subnet" {
  
  count = 4
  vpc_id = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = merge(
    local.default_tags, {
      Name = "${var.prefix}-public-subnet-${var.env}"
    }
  )
}


# Create a new Subnet
resource "aws_subnet" "private_subnet" {
  
  count = 2
  vpc_id = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = merge(
    local.default_tags, {
      Name = "${var.prefix}-private-subnet-${var.env}"
    }
  )
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-igw"
    }
  )
}


# Route table to route add default gateway pointing to Internet Gateway (IGW)
# Connected VPC
# Connected Internet Gatewway
# Assigned cidr_block = "0.0.0.0/0"
resource "aws_route_table" "public_subnets" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.prefix}-route-public-subnets"
  }
}


# Associate subnets with the custom route table
resource "aws_route_table_association" "public_route_table_association" {
  count          = length(aws_subnet.public_subnet[*].id)
  route_table_id = aws_route_table.public_subnets.id
  subnet_id      = aws_subnet.public_subnet[count.index].id
}

# Saving availability_zone in data variable
data "aws_availability_zones" "available" {
  state = "available"
}

# Define tags locally
locals {
  default_tags = merge(var.default_tags, { "env" = var.env })
}
