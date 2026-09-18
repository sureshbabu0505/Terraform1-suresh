locals {

  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = {
    Name        = local.name_prefix
    Project     = var.project_name
    Environment = var.environment
    Managedby   = "Terraform"
  }
}


# -------------------------
# VPC
# -------------------------

resource "aws_vpc" "this" {

  cidr_block = var.vpc_cidr

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-vpc"
    }
  )
}


# -------------------------
# Internet Gateway
# -------------------------

resource "aws_internet_gateway" "this" {

  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${local.name_prefix}-igw"
  }
}


# -------------------------
# Public Subnets
# -------------------------

resource "aws_subnet" "public" {

  for_each = var.public_subnet

  vpc_id = aws_vpc.this.id

  cidr_block = each.value.cidr_block

  availability_zone = each.value.availability_zone

  tags = {
    Name = "${local.name_prefix}-${each.key}"
    Type = each.value.subnet_type
  }
}


# -------------------------
# Private Subnets
# -------------------------

resource "aws_subnet" "private" {

  for_each = var.private_subnet

  vpc_id = aws_vpc.this.id

  cidr_block = each.value.cidr_block

  availability_zone = each.value.availability_zone

  tags = {
    Name = "${local.name_prefix}-${each.key}"
    Type = each.value.subnet_type
  }
}


# -------------------------
# Public Route Table
# -------------------------

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.this.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.this.id
  }

  tags = {

    Name = "${local.name_prefix}-public-rt"
  }
}


# -------------------------
# Public Route Associations
# -------------------------

resource "aws_route_table_association" "public" {

  for_each = aws_subnet.public

  subnet_id = each.value.id

  route_table_id = aws_route_table.public.id
}