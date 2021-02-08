#!/bin/bash


name=$(whoami)
home=$(~)
userid=$(id | awk -F " " '{print $1}'| cut -d "=" -f2)
groupid=$(id | awk -F " " '{print $2}' | cut -d "=" -f2)
term=$(bash --version | awk '(NR == 1)' | cut -d "," -f1)
dir=$(pwd)
dt=$(date)

echo "Home dir: $home"
echo "User Name: $name"
echo "User ID: $userid"
echo "Group Information: $groupid"
echo "Terminal is: $term"
echo "Current directory: $dir"
echo "System date/time: $dt"

exit 0 
