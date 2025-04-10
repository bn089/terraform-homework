
resource "aws_instance" "web1" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.sg_oregon.id]
    subnet_id = aws_subnet.public_subnets[1].id
    associate_public_ip_address = true
    user_data = file("apache.sh")
    key_name = aws_key_pair.deployer.id
tags = {
    Name = "Ubuntu"
}
}


resource "aws_instance" "web2" {

    ami = data.aws_ami.amazon.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.sg_oregon.id]
    subnet_id = aws_subnet.public_subnets[0].id
    associate_public_ip_address = true
    key_name = aws_key_pair.deployer.id
    user_data = file("httpd.sh")
tags = {
    Name = "Amazon"
}
}
