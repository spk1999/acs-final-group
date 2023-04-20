# output "subnet_id" {
  
#   #terraform state list aws_instance.bar#value = aws_subnet.public_subnet.id
#   value = aws_subnet.public_subnet[*].id

# }

# output "vpc_id" {
#   value = aws_vpc.main.id
# }

output "public_subnet_ids" {
  value = module.vpc-prod.subnet_id
}

output "vpc_id" {
  value = module.vpc-prod.vpc_id
}