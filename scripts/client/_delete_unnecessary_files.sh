#!/bin/bash

# Delete unnecessary file if it exists
if [ -f ".eslintrc.json" ]; then
  echo "Deleting .eslintrc.json file..."
  rm .eslintrc.json
  echo ".eslintrc.json file deleted successfully."
else
  echo ".eslintrc.json file not found. No need to delete."
fi

if [ -f "vite.config.js" ]; then
  echo "Deleting vite.config.js file..."
  rm vite.config.js
  echo "vite.config.js file deleted successfully."
else
  echo "vite.config.js file not found. No need to delete."
fi

if [ -f "file_to_delete2.js" ]; then
  echo "Deleting file_to_delete2.js file..."
  rm file_to_delete2.js
  echo "file_to_delete2.js file deleted successfully."
else
  echo "file_to_delete2.js file not found. No need to delete."
fi

# Add more deletion logic for other files as needed

echo "Deletion of specified files completed."
