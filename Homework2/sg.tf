variable "security_group_id" {
  description = "The ID of the existing security group"
  type        = string
}

data "aws_security_group" "allow_tls" {
  id = var.security_group_id
}
