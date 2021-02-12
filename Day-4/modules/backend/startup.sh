#!/bin/bash


sudo yum install -y tomcat tomcat-webapps tomcat-admin-webapps tomcat-docs-webapp tomcat-javadoc wget
sudo systemctl enable tomcat
sudo systemctl start tomcat
wget -P /usr/share/tomcat/webapps https://github.com/rrhawk/test_repo/raw/main/Day-4/modules/backend/clusterjsp.war
