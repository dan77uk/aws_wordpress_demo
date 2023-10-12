output "vpc" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = aws_subnet.public_subnets[*].id
}

output "private_app_subnets" {
  value = aws_subnet.private_subnets_application[*].id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.rds_subnet_group.name
}
