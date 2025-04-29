#!/bin/bash

# Set the Instance ID and path to the .env file
INSTANCE_ID="i-0ce3b250da2fe8079"

# Retrieve the public IP address of the specified EC2 instance
ipv4_address=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

# Path to the .env file
file_to_find="../backend/.env"

# Check the current BACKEND_URL in the .env file
current_url=$(sed -n "4p" $file_to_find)

# Update the .env file if the IP address has changed
if [[ "$current_url" != "BASE_URL=\"http://${ipv4_address}:8888\"" ]]; then
    if [ -f $file_to_find ]; then
        sed -i -e "s|BASE_URL.*|BASE_URL=\"http://${ipv4_address}:8888\"|g" $file_to_find
    else
        echo "ERROR: File not found."
    fi
fi
