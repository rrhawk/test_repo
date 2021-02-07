#!/bin/bash


ot=$(ps -ef | grep [h]ttpd)

if [echo "$ot"]


#ps -ef | grep [h]ttpd;



then

	echo "This machine is running a web server."

else
echo "No Server"
fi
exit 0
