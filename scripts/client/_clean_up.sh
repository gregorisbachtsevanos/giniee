#!/bin/bash

# Function to create 'scripts' directory if it doesn't exist and move .sh files
move_sh_files_to_scripts_directory() {
  local scripts_dir="giniee"

  # Create 'scripts' directory if it doesn't exist
  if [ ! -d "$scripts_dir" ]; then
    mkdir "$scripts_dir"
    echo "Created directory '$scripts_dir'."
  fi

  # Move all .sh files to 'scripts' directory
  for file in *.sh; do
    if [ "$file" != "$0" ]; then  # Exclude this script itself from moving
      mv "$file" "$scripts_dir/"
      echo "Moved '$file' to '$scripts_dir/'."
    fi
  done
}

# Function to delete .sh files
delete_sh_files() {
  for file in *.sh; do
    if [ "$file" != "$0" ]; then  # Exclude this script itself from deletion
      rm "$file"
      echo "Deleted '$file'."
    fi
  done
}

# Prompt user for action
echo "What would you like to do?"
PS3="Enter your choice: "
options=("Move .sh files to new directory" "Delete .sh files")
select opt in "${options[@]}"; do
  case "$opt" in
    "Move .sh files to new directory")
      move_sh_files_to_scripts_directory
      break
      ;;
    "Delete .sh files")
      delete_sh_files
      break
      ;;
    *) echo "Invalid option";;
  esac
done
