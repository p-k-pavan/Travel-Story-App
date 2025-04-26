#!/bin/bash

INSTANCE_ID=i-0ce3b250da2fe8079

# Get public IP address of the instance
ipv4_address=$(aws ec2 describe-instances --instance-ids "$INSTANCE_ID" --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

file_to_find="../backend/.env"

# Check if file exists
if [ ! -f "$file_to_find" ]; then
    echo "ERROR: File not found."
    exit 1
fi

# Read the content of the .env file
current_url=$(cat "$file_to_find")

# Update the .env file if the IP address has changed
if [[ "$current_url" != *"BASE_URL=\"http://${ipv4_address}:8888\""* ]]; then
    sed -i -e "s|^BASE_URL=.*|BASE_URL=\"http://${ipv4_address}:8888\"|g" "$file_to_find"
    echo "BASE_URL updated to http://${ipv4_address}:8888"
else
    echo "BASE_URL already up-to-date."
fi
