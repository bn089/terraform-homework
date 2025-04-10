
resource "aws_vpc" "main" {
  cidr_block = var.vpc.cidr
  enable_dns_support = var.vpc.dns_support
  enable_dns_hostnames = var.vpc.dns_hostname

  tags = local.common_tags
}

resource "aws_key_pair" "deployer" {
  key_name   = "homework4-key"
  public_key = file("~/.ssh/id_rsa.pub")

  tags = local.common_tags
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  count = length(var.subnets[0].cidr)
  cidr_block = var.subnets[0].cidr[count.index]
  availability_zone = var.subnets[0].availability_zone[count.index]
  map_public_ip_on_launch = var.subnets[0].map_public_ip_on_launch

  tags = {
    Name = "Public ${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  count = length(var.subnets[1].cidr)
  cidr_block = var.subnets[1].cidr[count.index]
  availability_zone = var.subnets[1].availability_zone[count.index]
  map_public_ip_on_launch = var.subnets[1].map_public_ip_on_launch

  tags = {
    Name = "Private ${count.index + 1}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  count = var.igw == "" ? 1 : 0
  tags = {
    Name = "IGW"
  }
}

resource "aws_route_table" "public" {
  count = length(var.route_tables)
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw[0].id
  }
    tags = {
      Name = var.route_tables[count.index]
    }
  }

resource "aws_route_table_association" "public" {
  count = length(var.subnets[0].cidr)
  subnet_id = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public[0].id
}

resource "aws_route_table_association" "private" {
  count = length(var.subnets[1].cidr)
  subnet_id = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.public[1].id
}

resource "aws_security_group" "sg_homework4" {
  name        = "sg_homework4"
  description = "Allow TLS inbound traffic"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = var.port[0] 
    to_port     = var.port[0] 
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = var.port[1]
    to_port     = var.port[1]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    description = "TLS from VPC"
    from_port   = var.port[2] 
    to_port     = var.port[2] 
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = var.port[3]
    to_port     = var.port[3]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

resource "aws_instance" "web" {
  ami           = var.ec2.ami
  instance_type = var.ec2.type
  tags = local.common_tags
}

