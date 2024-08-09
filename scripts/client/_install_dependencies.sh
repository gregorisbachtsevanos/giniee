#!/bin/bash

echo "Installing Prettier, env-cmd, and other dev dependencies"
npm install --save-dev prettier eslint eslint-config-prettier eslint-plugin-prettier env-cmd

echo "Installing Vite plugins"
npm install --save-dev vite @vitejs/plugin-react vite-plugin-mkcert vite-plugin-svgr vite-tsconfig-paths

echo "Prettier, env-cmd, Vite plugins, and other dev dependencies installed successfully."
