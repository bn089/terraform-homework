variable "iam_users1" {
  type = set(string)
  default = ["jisoo", "rose", "jennie", "lisa"]
}

variable "iam_group1" {
  type = string 
  default = "blackpink"
}

resource "aws_iam_user" "users1" {
  for_each = var.iam_users1
  name = each.value
  }

resource "aws_iam_group" "group1" {
  name = var.iam_group1
}

resource "aws_iam_group_membership" "group_membership" {
  name = "${var.iam_group1}_membership"
  group = aws_iam_group.group1.name
  users = [for user in aws_iam_user.users1 : user.name]
}



variable "iam_users2" {
  type = set(string)
  default = ["jihyo", "sana", "momo", "dahyun"]
}

variable "iam_group2" {
  type = string 
  default = "twice"
}

resource "aws_iam_user" "users2" {
  for_each = var.iam_users2
  name = each.value
  }

resource "aws_iam_group" "group2" {
  name = var.iam_group2
}

resource "aws_iam_group_membership" "team" {
  name = "${var.iam_group2}_membership"
  group = aws_iam_group.group2.name
  users = [for user in aws_iam_user.users2 : user.name]
}


resource "aws_iam_user" "user1" {
    name = "mina"
}

resource "aws_iam_user" "user2" {
    name = "miyeon"
}

data "aws_iam_group" "blackpink" {
  group_name = "blackpink"
}


data "aws_iam_group" "twice" {
  group_name = "twice"
}

resource "aws_iam_group_membership" "miyeon_blackpink" {
  name  = "miyeon_blackpink_membership"
  users = [aws_iam_user.user2.name]
  group = data.aws_iam_group.blackpink.group_name 
}

resource "aws_iam_group_membership" "mina_twice" {
  name  = "mina_twice_membership"
  users = [aws_iam_user.user1.name]
  group = data.aws_iam_group.twice.group_name  
}