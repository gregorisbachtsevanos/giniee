#!/bin/bash

read -p "Would you like to include a Dockerfile in the project? (Y/n): " include_dockerfile
include_dockerfile=${include_dockerfile:-Y}

if [[ "$include_dockerfile" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  DOCKERFILE_CONTENT="FROM node:14

WORKDIR /app

COPY package.json ./
RUN npm install

COPY . .

CMD [ \"npm\", \"start\" ]"

  echo "$DOCKERFILE_CONTENT" > Dockerfile
fi
