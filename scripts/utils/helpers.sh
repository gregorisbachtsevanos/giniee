#!/bin/bash

# ANSI color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;36m'
YELLOW='\033[38;5;227m'
PURPLE='\033[38;5;92m'
LIGHT_GREEN='\033[38;5;120m'
LIGHT_RED='\033[38;5;203m'
NC='\033[0m' # No Color

# Variable to track setup status
SETUP_SUCCESS=true
ERROR_LOG=""

# Function to print colored messages
print_colored() {
  local color=$1
  local message=$2
  echo -e "${color}${message}${NC}"
}

# Function to display messages in green color
print_success() {
  echo -e "${GREEN}$1${NC}"
}

# Function to display messages in red color
print_error() {
  echo -e "${RED}$1${NC}"
}