#!/bin/bash

# ANSI color codes
GREEN='\033[0;32m'
LIGHT_GREEN='\033[38;5;120m'
RED='\033[0;31m'
LIGHT_RED='\033[38;5;203m'
BLUE='\033[0;36m'
PURPLE='\033[38;5;92m'
YELLOW='\033[38;5;227m'
NC='\033[0m'

# Function to display messages in green color
print_success() {
  echo -e "${GREEN}$1${NC}"
}

# Function to display messages in red color
print_error() {
  echo -e "${RED}$1${NC}"
}

print_colored() {
  local color=$1
  local message=$2
  echo -e "${color}${message}${NC}"
}

# Prompt for project name
read -p "Enter the project name: " PROJECT_NAME
if [ -z "$PROJECT_NAME" ]; then
  print_error "Project name cannot be empty."
  exit 1
fi

# List of templates
options=(
    "$(print_colored "$BLUE" "react")"
    "$(print_colored "$LIGHT_GREEN" "vue")"
    "$(print_colored "$LIGHT_RED" "angular")"
    "$(print_colored "$PURPLE" "preact")"
    "$(print_colored "$YELLOW" "vanilla")"
)

# Menu-driven selection using select loop
PS3="Select a template (enter number): "
select TEMPLATE in "${options[@]}"; do
  case "$TEMPLATE" in
    "$(print_colored "$BLUE" "react")")
      TEMPLATE="react"
      break
      ;;
    "$(print_colored "$LIGHT_GREEN" "vue")")
      TEMPLATE="vue"
      break
      ;;
    "$(print_colored "$LIGHT_RED" "angular")")
      TEMPLATE="angular"
      break
      ;;
    "$(print_colored "$PURPLE" "preact")")
      TEMPLATE="preact"
      break
      ;;
    "$(print_colored "$YELLOW" "vanilla")")
      TEMPLATE="vanilla"
      break
      ;;
    *)
      echo "Invalid option. Please select a valid template."
      ;;
  esac
done

# Prompt for TypeScript or JavaScript usage
PS3="Select a variant (enter number): "
select LANGUAGE in "$(print_colored "$BLUE" "TypeScript")" "$(print_colored "$YELLOW" "JavaScript")"; do
  case "$LANGUAGE" in
    "$(print_colored "$BLUE" "TypeScript")")
      USE_TS=true
      break
      ;;
    "$(print_colored "$YELLOW" "JavaScript")")
      USE_TS=false
      break
      ;;
    *)
      echo "Invalid option. Please select a valid language."
      ;;
  esac
done


# Step 1: Initialize a Vite project in the current directory
print_success "Initializing Vite project..."
if ! npx create-vite@latest . --template "$TEMPLATE" --$USE_TS; then
  print_error "Failed to initialize Vite project."
  exit 1
fi

print_success "Vite project '$PROJECT_NAME' initialized successfully."
