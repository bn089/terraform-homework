variable "public_subnet_cidrs" {
    type = list 
    description = "CIDR values for public subnets"
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "azs_public" {
    type = list
    description = "Availability zones for public subnets"
    default = ["us-west-2a", "us-west-2b"]
}

variable "private_subnet_cidrs" {
    type = list 
    description = "CIDR values for private subnets"
    default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "azs_private" {
    type = list
    description = "Availability zones for private subnets"
    default = ["us-west-2c", "us-west-2d"]
}