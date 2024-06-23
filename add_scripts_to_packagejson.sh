#!/bin/bash

# Add scripts to package.json
echo "Adding scripts to package.json"
npx json -I -f package.json -e 'this.scripts["dev:uat"]="env-cmd -f .env.uat vite"'
npx json -I -f package.json -e 'this.scripts["dev:prod"]="env-cmd -f .env.prod vite"'
npx json -I -f package.json -e 'this.scripts["build:uat"]="env-cmd -f .env.uat vite build"'
npx json -I -f package.json -e 'this.scripts["build:prod"]="env-cmd -f .env.prod vite build"'

echo "Scripts added to package.json successfully."
