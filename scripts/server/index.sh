#!/bin/bash

# Source the utility functions
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../utils && pwd )/helpers.sh"

# Get the absolute path to the giniee root directory
GINIEE_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../../ && pwd )"

# # Variable to track setup status
# SETUP_SUCCESS=true
# ERROR_LOG=""

# Execute each script with error handling
execute_script() {
  local script_name="$1"
  local description="$2"
  if [ "$SETUP_SUCCESS" = true ]; then
    print_success "Executing $description..."
    if ! bash "$script_name"; then
      print_error "Error executing $description"
      SETUP_SUCCESS=false
      ERROR_LOG+="Error executing $description\n"
      print_error "Setup was not completed successfully. Please check the logs for errors."
      exit 1  # Exit the script if an error occurs
    fi
  else
    ERROR_LOG+="Error executing $description\n"
  fi
}

sh_files=$(ls *.sh 2>/dev/null)


# Execute each script
execute_script "$GINIEE_ROOT/init_project.sh" "init_project.sh"
execute_script "$GINIEE_ROOT/create_env_files.sh" "create_env_files.sh"
execute_script "$GINIEE_ROOT/create_directory_structure.sh" "create_directory_structure.sh"
execute_script "$GINIEE_ROOT/install_dependencies.sh" "install_dependencies.sh"
execute_script "$GINIEE_ROOT/create_www_file.sh" "create_www_file.sh"
execute_script "$GINIEE_ROOT/create_controller_file.sh" "create_controller_file.sh"
execute_script "$GINIEE_ROOT/create_handler_file.sh" "create_handler_file.sh"
execute_script "$GINIEE_ROOT/create_service_file.sh" "create_service_file.sh"
execute_script "$GINIEE_ROOT/create_model_file.sh" "create_model_file.sh"
execute_script "$GINIEE_ROOT/create_dbConnection_file.sh" "create_dbConnection_file.sh"
execute_script "$GINIEE_ROOT/create_middlewares_files.sh" "create_middlewares_files.sh"
execute_script "$GINIEE_ROOT/create_app_file.sh" "create_app_file.sh"
execute_script "$GINIEE_ROOT/create_type_file.sh" "create_type_file.sh"
execute_script "$GINIEE_ROOT/create_config_file.sh" "create_config_file.sh"
execute_script "$GINIEE_ROOT/create_project_config_files.sh" "create_project_config_files.sh"

execute_script "$GINIEE_ROOT/dockerfile_interactive.sh" "dockerfile_interactive.sh"
execute_script "$GINIEE_ROOT/add_scripts_to_packagejson.sh" "add_scripts_to_packagejson.sh"

if [ -n "$sh_files" ]; then
  execute_script "$GINIEE_ROOT/clean_up.sh" "clean_up.sh"
fi

if [ "$SETUP_SUCCESS" = true ]; then
  print_success "Setup completed successfully."
fi
