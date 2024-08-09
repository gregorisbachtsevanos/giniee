read -p "Would you like to include a Dockerfile in the project? (Y/n): " include_dockerfile
include_dockerfile=${include_dockerfile:-Y}

if [[ "$include_dockerfile" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  DOCKERFILE_CONTENT="FROM node:14

# Stage 1: Build Stage
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Production Stage
FROM node:18-alpine AS production

# Set working directory
WORKDIR /app

# Copy only the built application and package.json
COPY --from=builder /app/dist /app/dist
COPY --from=builder /app/package*.json ./

# Install only production dependencies
RUN npm install --production

# Copy environment files
COPY .env.prod .env

# Set environment variables
ENV NODE_ENV=production
ENV PORT=4000

# Expose the application port
EXPOSE 4000

# Run the application
CMD ["node", "./dist/bin/www.js"]"

  echo "$DOCKERFILE_CONTENT" > Dockerfile
fi
