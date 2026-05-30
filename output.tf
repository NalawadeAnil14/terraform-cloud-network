output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main_vpc.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main_vpc.cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the created public subnets"
  value       = { for az, sub in aws_subnet.public_subnet : "${az}-public" => sub.id }
}

output "private_subnet_ids" {
  description = "IDs of the created private subnets"
  value       = { for az, sub in aws_subnet.private_subnet : "${az}-private" => sub.id }
}

output "internet_gateway_id" {
  description = "ID of the created Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "availability_zones" {
  description = "List of availability zones used for subnets"
  value       = var.availability_zones
}
