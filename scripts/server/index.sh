#!/bin/bash

# Source the utility functions
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../utils && pwd )/helpers.sh"

# Get the absolute path to the giniee root directory
GINIEE_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../../ && pwd )"


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
execute_script "$GINIEE_ROOT/scripts/init_project.sh" "init_project.sh"
execute_script "$GINIEE_ROOT/scripts/create_env_files.sh" "create_env_files.sh"
execute_script "$GINIEE_ROOT/scripts/create_directory_structure.sh" "create_directory_structure.sh"
execute_script "$GINIEE_ROOT/scripts/install_dependencies.sh" "install_dependencies.sh"
execute_script "$GINIEE_ROOT/scripts/create_www_file.sh" "create_www_file.sh"
execute_script "$GINIEE_ROOT/scripts/create_router_file.sh" "create_router_file.sh"
execute_script "$GINIEE_ROOT/scripts/create_controller_file.sh" "create_controller_file.sh"
execute_script "$GINIEE_ROOT/scripts/create_handler_file.sh" "create_handler_file.sh"
execute_script "$GINIEE_ROOT/scripts/create_service_file.sh" "create_service_file.sh"
execute_script "$GINIEE_ROOT/scripts/create_model_file.sh" "create_model_file.sh"
execute_script "$GINIEE_ROOT/scripts/create_dbConnection_file.sh" "create_dbConnection_file.sh"
execute_script "$GINIEE_ROOT/scripts/create_middlewares_files.sh" "create_middlewares_files.sh"
execute_script "$GINIEE_ROOT/scripts/create_app_file.sh" "create_app_file.sh"
execute_script "$GINIEE_ROOT/scripts/create_type_file.sh" "create_type_file.sh"
execute_script "$GINIEE_ROOT/scripts/create_config_file.sh" "create_config_file.sh"
execute_script "$GINIEE_ROOT/scripts/create_project_config_files.sh" "create_project_config_files.sh"

execute_script "$GINIEE_ROOT/scripts/dockerfile_interactive.sh" "dockerfile_interactive.sh"
execute_script "$GINIEE_ROOT/scripts/add_scripts_to_packagejson.sh" "add_scripts_to_packagejson.sh"

if [ -n "$sh_files" ]; then
  execute_script "$GINIEE_ROOT/scripts/clean_up.sh" "clean_up.sh"
fi

if [ "$SETUP_SUCCESS" = true ]; then
  print_success "Setup completed successfully."
fi
