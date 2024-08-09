#!/bin/bash

# Create directory structure
echo "Creating directory structure"
mkdir -p src
mkdir -p src/{bin,config,controllers,middlewares,models,routes,services}
mkdir -p src/controllers/handlers

echo "Directory structure created successfully."
