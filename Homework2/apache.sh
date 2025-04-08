#!/bin/bash

sudo apt update
sudo apt-get install apache2 -y
sudo systemctl start apache2 
sudo systemctl enable apache2
echo "Hello, World!" > /var/www/html/index.html
