#!/bin/bash
export IMAGE_FAMILY="centos-7"
export ZONE="us-central1-c"
export INSTANCE_NAME="nginx-gcloud"
export INSTANCE_TYPE="n1-custom-1-4608"
gcloud compute instances create $INSTANCE_NAME \
        --zone=$ZONE \
        --image-project=my-12345-project \
        --image-family=$IMAGE_FAMILY \
        --machine-type=$INSTANCE_TYPE \
        --boot-disk-size=35GB \
        --boot-disk-type="pd-ssd" \
        --labels server-type=nginx-server,os-family=redhat,way-of-installation=gcloud \
        --tags http-server,https-server \
        --metadata-from-file="startup-script"="/home/user/test_repo/lesson-2/startup.sh" \
        --image-project=centos-cloud \
        --deletion-protection
