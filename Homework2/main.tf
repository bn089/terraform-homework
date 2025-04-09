resource "aws_key_pair" "deployer" {
  key_name   = "bastion-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

variable "instances" {
    default = {
        "web-1" = "us-west-2a"
         "web-2" = "us-west-2b"
          "web-3" = "us-west-2c"
    }
}
resource "aws_instance" "web" {
    for_each = var.instances
  ami           = "ami-03f8acd418785369b"
  instance_type = "t2.micro"
  associate_public_ip_address = true 
  availability_zone = each.value
  key_name = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.sg_ohio.id]
  user_data = file("apache.sh")

  tags = { 
    Name = each.key
  }
}