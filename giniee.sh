#!/bin/bash

# Source the utility functions
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/scripts/utils/helpers.sh"

# Prompt for the new project directory name
read -p "Enter the name of the new project directory: " PROJECT_DIR

# Validate the directory name
if [ -z "$PROJECT_DIR" ]; then
  print_error "Project directory name cannot be empty."
  exit 1
fi

# Create the new directory inside the giniee folder
NEW_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/$PROJECT_DIR"

if [ -d "$NEW_DIR" ]; then
  print_error "Directory '$PROJECT_DIR' already exists. Please choose a different name."
  exit 1
fi

mkdir "$NEW_DIR"
print_success "Created directory: $NEW_DIR"

# Prompt the user for input
PS3=$(print_colored "$GREEN" "Select the project type: ")

options=("$(print_colored "$BLUE" "Server side project")" "$(print_colored "$YELLOW" "Client side project")")

select opt in "${options[@]}"; do
  case "$REPLY" in
    1)
      SCRIPT_TO_RUN="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/scripts/server/index.sh"
      break
      ;;
    2)
      SCRIPT_TO_RUN="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/scripts/client/_index.sh"
      break
      ;;
    *)
      print_colored "$RED" "Invalid option. Please select a valid project type."
      ;;
  esac
done

# Check if the index.sh script exists
if [ ! -f "$SCRIPT_TO_RUN" ]; then
  print_colored "$RED" "Error: $SCRIPT_TO_RUN not found."
  exit 1
fi

# Ensure the index.sh script is executable
chmod +x "$SCRIPT_TO_RUN"

# Change to the newly created directory and run the appropriate script
cd "$NEW_DIR"
print_success "Running script at: $SCRIPT_TO_RUN"
"$SCRIPT_TO_RUN"