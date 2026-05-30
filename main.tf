resource "aws_vpc" "main_vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "${var.name}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "${var.name}-igw"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main_vpc.id

  for_each   = toset(var.availability_zones)
  cidr_block = cidrsubnet(var.cidr_block, 8, index(var.availability_zones, each.key))

  availability_zone = each.key

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-public-subnet-${index(var.availability_zones, each.key) + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.main_vpc.id

  for_each = toset(var.availability_zones)

  cidr_block = cidrsubnet(var.cidr_block, 8, index(var.availability_zones, each.key) + 100)

  availability_zone = each.key

  tags = {
    Name = "${var.name}-private-subnet-${index(var.availability_zones, each.key) + 1}"
  }
}

resource "aws_route_table" "public_rout_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    gateway_id = aws_internet_gateway.igw.id
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "${var.name}-public-rout-table"
  }
}

resource "aws_route_table_association" "rtassociation" {
  for_each = aws_subnet.public_subnet

  route_table_id = aws_route_table.public_rout_table.id
  subnet_id      = each.value.id
}

resource "aws_iam_user" "demo" {
}
