#!/bin/bash

echo "Installing Dependencies"
npm install @types/cookie-parser @types/cors @types/debug @types/express @types/http-errors @types/mongoose @types/morgan bcryptjs cookie-parser cors debug deep-email-validator dotenv express geoip-lite http-errors jsonwebtoken log4js mongodb mongoose morgan multer uuid

echo "Installing Dev Dependencies"
npm install --save-dev @types/geoip-lite @types/uuid dotenv-cli nodemon ts-node tsconfig-paths typescript eslint

echo "Prettier, env-cmd, Vite plugins, and other dev dependencies installed successfully."