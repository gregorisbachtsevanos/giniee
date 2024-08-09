#!/bin/bash

# Function to create an env file and add variables
create_env_file() {
  local filename=$1
  echo "Creating $filename"
  
  if [ -f "$filename" ]; then
    echo "$filename already exists. Overwriting..."
  fi

  cat <<EOL > $filename
# Environment variables for $filename
MONGODB_URI=http://your-mongodb-url
SERVER_URL=your-server-url
CLIENT_URL=your-client-url
PORT=your-port
ENVIRONMENT=your-environment
CLIENT_SECRET=your-client-secret
MACHINE_SECRET=your-machine-secret

EOL

  echo "$filename created with example variables."
}

# Create .env.uat file
create_env_file ".env.uat"

# Create .env.prod file
create_env_file ".env.prod"

echo "Environment variable files created successfully."
