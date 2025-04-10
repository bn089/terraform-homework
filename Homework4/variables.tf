variable vpc {
    description = "CIDR block and DNS enable for VPC"
    type = object({
        cidr = string 
        dns_support = bool
        dns_hostname = bool
    })

    default = {
        cidr = "10.0.0.0/16"
        dns_support = true
        dns_hostname = true 
        }
    }

variable subnets {
    description = "CIDR block, AZ, Public IP for subnets"
    type = list(object({
        cidr = list(string)
        availability_zone = list(string)
        map_public_ip_on_launch = bool
    }))
    default = [{
        cidr = ["10.0.1.0/24", "10.0.2.0/24"]
        availability_zone = ["us-east-1a", "us-east-1b"]
        map_public_ip_on_launch = true
    },
    {
        cidr = ["10.0.3.0/24", "10.0.4.0/24"]
        availability_zone = ["us-east-1c", "us-east-1d"]
        map_public_ip_on_launch = true
    }
    ]
}

variable "igw" {
    description = "IGW"
    type = string
    default = ""
}

variable "route_tables" {
    description = "Route tables for public and private subnets"
    type = list(string)
    default = ["public-rt", "private-rt"]
}

variable "port" {
description = "Security Group ports"
  default = [22, 80, 443, 3306]
  type    = list(number)
}


variable "ec2" {
    description = "EC2"
    type = object({
        ami = string
        type = string
    })
    default = {
        ami = "ami-00a929b66ed6e0de6"
        type = "t2.micro"
    }

}