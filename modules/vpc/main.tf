resource "aws_vpc" "VPC" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    instance_tenancy = "default"

    tags = {
      "Name" = var.vpc_name
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.VPC.id
    cidr_block = var.public_subnet_cidr
    map_public_ip_on_launch = true
    availability_zone = var.public_subnet_az
    tags = {
        "Name" = var.public_subnet_name
    }
}
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.VPC.id
    cidr_block = var.private_subnet_cidr
    map_public_ip_on_launch = false
    availability_zone = var.private_subnet_az
    tags = {
        "Name" = var.private_subnet_name
    }
}

resource "aws_subnet" "database" {
    vpc_id = aws_vpc.VPC.id
    cidr_block = var.database_subnet_cidr
    map_public_ip_on_launch = false
    availability_zone = var.database_subnet_az
    tags = {
        "Name" = var.database_subnet_name
    }
}

### more complicated Networking configurations
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.VPC.id
    tags = {
      Name = var.igw_name
    }  
}

resource "aws_route_table" "public-crt" {
    vpc_id =   aws_vpc.VPC.id
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
      "Name" = var.public_route_table_name
    }
}

resource "aws_route_table_association" "crta-public-subnet" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public-crt.id
}

# Our Private subnet can reach internet
# Make the Internet (all addresses) to be outbound reachable 
# from `Private-ec2` for purposes software update. 
# Use NAT Gateway for this

# NAT Gateway with Elastic IP
# Create 
# - Elastic IP, and then 
# - NAT gateway associated with the private subnet
# - Routing table which routes everything to NAT gateway
resource "aws_eip" "nat_gateway" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id = aws_subnet.public.id
  tags = {
    "Name" = var.nat_gateway_name
  }
}

resource "aws_route_table" "private_sub_route_table" {
  vpc_id = aws_vpc.VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

resource "aws_route_table_association" "private_sub_route_association" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private_sub_route_table.id
}