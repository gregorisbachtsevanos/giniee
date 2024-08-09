#!/bin/bash

# Create src/config.ts file
CONFIG_TS_CONTENT="const config = {
  mongodbURL: process.env.MONGODB_URI,
  serverURL: process.env.SERVER_URL,
  clientURL: process.env.CLIENT_URL,
  apiToAuthenticate: process.env.PORT,
  environment: process.env.ENVIRONMENT,
  auth: {
    clientSecret: process.env.CLIENT_SECRET,
    clientId: 'project.client',
    machineSecret: process.env.MACHINE_SECRET,
    machineId: 'project.machine.client',
    type: 'project',
  },
};

export default config;"

echo "$CONFIG_TS_CONTENT" > "src/config.ts"

