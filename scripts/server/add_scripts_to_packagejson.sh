#!/bin/bash

# Add scripts to package.json
echo "Adding scripts to package.json"
npx json -I -f package.json -e 'this.scripts["lint"]="eslint ."'
npx json -I -f package.json -e 'this.scripts["start"]="node ./dist/bin/www.js"'
npx json -I -f package.json -e 'this.scripts["build"]="tsc"'
npx json -I -f package.json -e 'this.scripts["dev"]="ts-node ./src/bin/www.ts"'
npx json -I -f package.json -e 'this.scripts["dev:uat"]="dotenv -e .env.uat nodemon ./src/bin/www.ts --ignore client"'
npx json -I -f package.json -e 'this.scripts["dev:prod"]="dotenv -e .env.prod nodemon ./src/bin/www.ts --ignore client"'

echo "Scripts added to package.json successfully."