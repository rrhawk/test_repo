#!/bin/bash

yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
