#!/bin/bash

# Source the utility functions
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../utils && pwd )/helpers.sh"

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

# Step 1: Initialize a Vite project in the current directory
print_success "Initializing Vite project..."
if ! npx create-vite@latest ./ --template "$TEMPLATE"; then
  print_error "Failed to initialize Vite project."
  exit 1
fi

print_success "Vite project initialized successfully."
