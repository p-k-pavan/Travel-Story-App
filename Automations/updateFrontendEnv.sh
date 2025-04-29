#!/bin/bash

# Set the EC2 instance ID
INSTANCE_ID="i-03ba8564e69fe9d98"

# Get the public IPv4 address from AWS CLI
ipv4_address=$(aws ec2 describe-instances --instance-ids "$INSTANCE_ID" \
  --query 'Reservations[0].Instances[0].PublicIpAddress' \
  --output text)

# Set the path to your .env file
file_to_find="../frontend/.env"

# Ensure the file exists
if [ ! -f "$file_to_find" ]; then
  echo "ERROR: File not found at $file_to_find"
  exit 1
fi

# Read current VITE_BASE_URL
current_url=$(grep '^VITE_BASE_URL=' "$file_to_find")
new_url="VITE_BASE_URL=\"http://${ipv4_address}:32000\""

echo "Current: $current_url"
echo "Target : $new_url"

# Update only if different
if [[ "$current_url" != "$new_url" ]]; then
  echo "Updating VITE_BASE_URL in .env..."
  sed -i -E "s|^VITE_BASE_URL=.*|$new_url|" "$file_to_find"
  echo ".env updated successfully."
else
  echo "No update needed. IP is unchanged."
fi
