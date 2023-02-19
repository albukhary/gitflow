output "vpc_id" {
    value = aws_vpc.VPC.id
}

output "public_subnet_id" {
    value = aws_subnet.public.id
}

output "private_subnet_id" {
    value = aws_subnet.private.id
}

output "database_subnet_id" {
    value = aws_subnet.database.id
}

output "vpc" {
  value = aws_vpc.VPC
}

output "subnet_private" {
  value = aws_subnet.private
}