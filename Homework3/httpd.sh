#!/bin/bash

sudo yum update -y
sudo yum install -y httpd 
sudo systemctl enable httpd
sudo systemctl start httpd
echo "Hello, World from Amazon!" > /var/www/html/index.html
