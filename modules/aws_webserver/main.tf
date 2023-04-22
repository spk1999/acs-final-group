provider "aws" {
  region = "us-east-1"
}

# # # Needs editing
# data "aws_ami" "latest_amazon_linux" {
#   owners      = ["amazon"]
#   most_recent = true
#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm-*-x86_64-gp2"]
#   }
# }

# # Availability Zones
# data "aws_availability_zones" "available" {
#   state = "available"
# }

# # This block is defined to get terraform state file from dev
# data "terraform_remote_state" "public_subnet" {
#   backend = "s3"
#   config = {
#     bucket = var.bucket_name
#     key    = var.remote_bucket_key
#     region = "us-east-1"
#   }
# }

# Define tags locally
locals {
  default_tags = merge(var.default_tags, { "env" = var.env })
}

# Webserver 1
resource "aws_instance" "my_amazon" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  key_name = aws_key_pair.week6.key_name
  subnet_id                   = element(data.terraform_remote_state.public_subnet.outputs.public_subnet_ids, 0)
  associate_public_ip_address = true
  availability_zone           = element(data.aws_availability_zones.available.names, 0)
  security_groups        =      [aws_security_group.acs730w6.id]
  

  # Added to encrypt if env = "production"
  root_block_device {
    encrypted = var.env == "prod" ? true : false
  }
  
  lifecycle {
    create_before_destroy = true
   }  
     tags = {
      "Name" = "Web-Amazon-Linux : Server 1"
    }
       user_data  = file("install_httpd.sh")

  
}



# Webserver 2
resource "aws_instance" "my_amazon1" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  key_name = aws_key_pair.week6.key_name
  subnet_id                   = element(data.terraform_remote_state.public_subnet.outputs.public_subnet_ids, 1)
  associate_public_ip_address = true
  availability_zone           = element(data.aws_availability_zones.available.names, 1)
  security_groups        =      [aws_security_group.acs730w6.id]
  user_data  = file("install_httpd.sh")

  

  # Added to encrypt if env = "production"
  root_block_device {
    encrypted = var.env == "prod" ? true : false
  }
  
  lifecycle {
    create_before_destroy = true
   }  
  
  
  tags =  {
      "Name" = "${var.prefix}-Amazon-Linux : ${var.env} Server 2"
    }
  
  

}




# Webserver 3
resource "aws_instance" "my_amazon2" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  key_name = aws_key_pair.week6.key_name
  subnet_id                   = element(data.terraform_remote_state.public_subnet.outputs.public_subnet_ids, 2)
  associate_public_ip_address = true
  availability_zone           = element(data.aws_availability_zones.available.names, 2)
  security_groups        =      [aws_security_group.acs730w6.id]
  

  # Added to encrypt if env = "production"
  root_block_device {
    encrypted = var.env == "prod" ? true : false
  }
  
  lifecycle {
    create_before_destroy = true
   }  
  
  tags = merge(var.default_tags,
    {
      "Name" = "${var.prefix}-Amazon-Linux : ${var.env} Server 3"
    }
  )
  

user_data  = file("install_httpd.sh")
}


# Webserver 4
resource "aws_instance" "my_amazon3" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  key_name = aws_key_pair.week6.key_name
  subnet_id                   = element(data.terraform_remote_state.public_subnet.outputs.public_subnet_ids, 3)
  associate_public_ip_address = true
  availability_zone           = element(data.aws_availability_zones.available.names, 3)
  security_groups        =      [aws_security_group.acs730w6.id]
  

  # Added to encrypt if env = "production"
  root_block_device {
    encrypted = var.env == "prod" ? true : false
  }
  
  lifecycle {
    create_before_destroy = true
   }  
  
  tags = merge(var.default_tags,
    {
      "Name" = "${var.prefix}-Amazon-Linux : ${var.env} Server 4"
    }
  )
  



user_data  = file("install_httpd.sh")
}

#security Group
resource "aws_security_group" "acs730w6" {
  name        = "allow_http_ssh"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = data.terraform_remote_state.public_subnet.outputs.vpc_id 

  ingress {
    description      = "HTTP from everywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH from everywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-EBS"
    }
  )
}



# Elastic IP
resource "aws_eip" "static_eip" {
  instance = aws_instance.my_amazon.id
  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-eip"
    }
  )
}



# Create another EBS volume
resource "aws_ebs_volume" "web_ebs" {
  count             = var.env == "prod" ? 1 : 0
  availability_zone = element(data.aws_availability_zones.available.names,1)
  size              = 40

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-EBS"
    }
  )
}


# Adding SSH  key to instance
resource "aws_key_pair" "week6" {
  key_name   = "week6-prod"
  public_key = file("keypair.pub")
}


#security Group
resource "aws_security_group" "private_sg" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.terraform_remote_state.public_subnet.outputs.vpc_id 

  ingress {
    description      = "SSH from everywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    security_groups  = [aws_security_group.acs730w6.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-EBS"
    }
  )
}



# Webserver 5
resource "aws_instance" "my_amazon4" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  key_name = aws_key_pair.week6.key_name
  subnet_id                   = element(data.terraform_remote_state.public_subnet.outputs.public_subnet_ids, 0)
  associate_public_ip_address = true
  availability_zone           = element(data.aws_availability_zones.available.names, 0)
  security_groups        =      [aws_security_group.private_sg.id]
  

  # Added to encrypt if env = "production"
  root_block_device {
    encrypted = var.env == "prod" ? true : false
  }
  
  lifecycle {
    create_before_destroy = true
   }  
  
  tags ={
      "Name" = "${var.prefix}-Amazon-Linux : ${var.env} Server 5"
    }
  
  
#user_data  = file("install_httpd.sh")
}

# Webserver 6
resource "aws_instance" "my_amazon5" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  key_name = aws_key_pair.week6.key_name
  subnet_id                   = element(data.terraform_remote_state.public_subnet.outputs.public_subnet_ids, 1)
  associate_public_ip_address = true
  availability_zone           = element(data.aws_availability_zones.available.names, 1)
  security_groups        =      [aws_security_group.private_sg.id]
  

  # Added to encrypt if env = "production"
  root_block_device {
    encrypted = var.env == "prod" ? true : false
  }
  
  lifecycle {
    create_before_destroy = true
   }  
  
  tags =  {
      "Name" = "${var.prefix}-Amazon-Linux : ${var.env} Server 6"
    }
  
  
#user_data  = file("install_httpd.sh")Meharaj
}