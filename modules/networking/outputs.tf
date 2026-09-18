output "vpc_id" {

  description = "VPC ID"

  value = aws_vpc.this.id
}


output "internet_gateway_id" {

  description = "Internet Gateway ID"

  value = aws_internet_gateway.this.id
}


output "public_subnet_ids" {

  description = "Map of public subnet IDs"

  value = {
    for name, subnet in aws_subnet.public :
    name => subnet.id
  }
}


output "private_subnet_ids" {

  description = "Map of private subnet IDs"

  value = {
    for name, subnet in aws_subnet.private :
    name => subnet.id
  }
}


output "public_subnet_details" {

  value = {

    for name, subnet in aws_subnet.public :

    name => {

      id                = subnet.id
      cidr_block        = subnet.cidr_block
      availability_zone = subnet.availability_zone

    }

  }
}


output "private_subnet_details" {

  value = {

    for name, subnet in aws_subnet.private :

    name => {

      id                = subnet.id
      cidr_block        = subnet.cidr_block
      availability_zone = subnet.availability_zone

    }

  }
}