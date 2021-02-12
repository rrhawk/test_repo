#!/bin/bash

yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
echo "Hello from Sergey Kosolapov" > /usr/share/nginx/html/index.html
sudo sed -i '48i\        proxy_pass http://lb;' /etc/nginx/nginx.conf
sudo sed -i  '23i\       upstream lb {    server 10.13.2.100:8080; }' /etc/nginx/nginx.conf
sudo setsebool httpd_can_network_connect 1
sudo systemctl restart nginx
