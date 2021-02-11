#!/bin/bash

yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
echo "Hello from Sergey Kosolapov" > /usr/share/nginx/html/index.html
