#!/bin/bash

# Source the utility functions
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../utils && pwd )/helpers.sh"

# Prompt for project name
read -p "Enter the project name: " PROJECT_NAME
if [ -z "$PROJECT_NAME" ]; then
  print_error "Project name cannot be empty."
  exit 1
fi

# Create the new project directory
mkdir "$PROJECT_NAME"
if [ $? -ne 0 ]; then
  print_error "Failed to create project directory '$PROJECT_NAME'."
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
      TEMPLATE="$TEMPLATE-ts"
      break
      ;;
    "$(print_colored "$YELLOW" "JavaScript")")
      print_colored "$RED" "Sorry, only TypeScript is supported. Defaulting to TypeScript."
      TEMPLATE="$TEMPLATE-ts"
      break
      ;;
    *)
      echo "Invalid option. Please select a valid language."
      ;;
  esac
done

# Step 1: Initialize a Vite project in the project directory
print_success "Initializing Vite project in '$PROJECT_NAME'..."
cd "$PROJECT_NAME" || { print_error "Failed to navigate to project directory '$PROJECT_NAME'."; exit 1; }
if ! npx create-vite@latest . --template "$TEMPLATE"; then
  print_error "Failed to initialize Vite project."
  exit 1
fi

print_success "Vite project '$PROJECT_NAME' initialized successfully."
