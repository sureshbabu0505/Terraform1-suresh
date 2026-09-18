variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "public_subnet" {
  description = "Public subnet configuration"

  type = map(object({
    cidr_block        = string
    availability_zone = string
    subnet_type       = string
  }))
}

variable "private_subnet" {
  description = "Private subnet configuration"

  type = map(object({
    cidr_block        = string
    availability_zone = string
    subnet_type       = string
  }))
}