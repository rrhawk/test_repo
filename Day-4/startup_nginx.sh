#!/bin/bash

yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
echo "Hello from Sergey Kosolapov" > /usr/share/nginx/html/index.html
sudo sed -i '48i\        proxy_pass http://lb;' /etc/nginx/nginx.conf
sudo sed -i  '23i\       upstream lb {    server 10.13.2.100:8080; }' /etc/nginx/nginx.conf
sudo setsebool httpd_can_network_connect 1
sudo systemctl restart nginx
#echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsgPL4xcYRKgQFz9W8xQ9mnWc9WMZxu2skx121st/f7w7QsEn4L++TCt77vsJ1nqRtfxF/MmXeC326QPulYW7YnOXTcGtmfuZQDVP72EBifglXBIz/CL0ChNfOLK7D5yH9SVpBJfKMU0XsWU+ObzEEpsPXbtC0kZahLRIroBuQjsV5gsaIVDiqIa2ztK1fDSKFXT9AfX1gnlll2Pp0JmVJbqi8gWnouS9Am10hZXm2HpCESBB4dZ9s2ZkYgWKZrXrIFO33ES/2IrLr2MdAsGjMBTlS57c5VSSqCP6PRZ7n08WM3wt41WmT+1EFof+XXgtWvCP95bY9gO2PGpoby15L aliaksandr_mazurenka" >> /root/.ssh/authorized_keys
