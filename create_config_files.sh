#!/bin/bash

# Function to create a JSON configuration file
create_json_file() {
  local filename=$1
  local content=$2
  echo "Creating $filename"
  
  if [ -f "$filename" ]; then
    echo "$filename already exists. Overwriting..."
  fi

  echo "$content" > $filename

  echo "$filename created with specified content."
}

# Create Eslintrc configuration file
ESLINTRC='{
  "plugins": ["react-refresh"],
  "rules": {
    "react-refresh/only-export-components": "warn"
  },
  "extends": "react-app"
}'
create_json_file ".eslintrc.cjs" "$ESLINTRC"

# Create Prettier configuration file
PRETTIER_CONFIG='{
  "singleQuote": true,
  "trailingComma": "es5",
  "printWidth": 100,
  "tabWidth": 2,
  "bracketSpacing": true,
  "bracketSameLine": false,
  "endOfLine": "auto"
}'
create_json_file ".prettierrc" "$PRETTIER_CONFIG"

# Create tsconfig.json file
TSCONFIG='{
  "compilerOptions": {
    "target": "ESNext",
    "useDefineForClassFields": true,
    "lib": ["DOM", "DOM.Iterable", "ESNext"],
    "allowJs": false,
    "skipLibCheck": true,
    "esModuleInterop": false,
    "allowSyntheticDefaultImports": true,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "module": "ESNext",
    "moduleResolution": "Node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "baseUrl": "./src"
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}'
create_json_file "tsconfig.json" "$TSCONFIG"

# Create tsconfig.node.json file
TSCONFIG_NODE='{
  "compilerOptions": {
    "composite": true,
    "module": "ESNext",
    "moduleResolution": "Node",
    "allowSyntheticDefaultImports": true
  },
  "include": ["vite.config.ts"]
}'
create_json_file "tsconfig.node.json" "$TSCONFIG_NODE"

# Rewrite vite.config.ts file
VITE_CONFIG='import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import mkcert from "vite-plugin-mkcert";
import svgr from "vite-plugin-svgr";
import tsconfigPaths from "vite-tsconfig-paths";

// https://vitejs.dev/config/
export default defineConfig({
  build: {
    outDir: "build",
  },
  server: {
    host: true,
    https: true,
    open: true,
    port: 3000,
  },
  preview: {
    port: 3000,
  },
  plugins: [react(), mkcert(), svgr(), tsconfigPaths()],
});
'
create_json_file "vite.config.ts" "$VITE_CONFIG"

echo "Configuration files created successfully."
