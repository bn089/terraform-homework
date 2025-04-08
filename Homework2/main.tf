variable "azs" {
    default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "instance_names" {
    default = ["web-1", "web-2", "web-3"]
}

resource "aws_instance" "web" {
  ami           = "ami-03f8acd418785369b"
  instance_type = "t2.micro"
  key_name = aws_key_pair.deployer.key_name
  count = length(var.instance_names)
  count = length(var.azs)
  availability_zone = var.azs[count.index]
  associate_public_ip_address = true

  tags = {
    Name = var.instance_names[count.index]
  }
}