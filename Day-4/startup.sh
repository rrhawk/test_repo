#!/bin/bash

sudo mkdir -p  /home/aliaksandr_mazurenka/.ssh
sudo echo "Host *

ForwardAgent yes" > /home/aliaksandr_mazurenka/.ssh/config
