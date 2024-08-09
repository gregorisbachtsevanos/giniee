#!/bin/bash

# Source the utility functions
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../utils && pwd )/helpers.sh"

# Step 1: Initialize a project in the current directory with the specified project name
print_success "Initializing project..."
if ! npm init ; then
  print_error "Failed to initialize project."
  exit 1
fi

# Step 2: Run npm install
print_success "Running npm install..."
if ! npm install; then
  print_error "npm install failed."
  exit 1
fi

print_success "Project initialized successfully."