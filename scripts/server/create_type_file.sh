#!/bin/bash

# Create src/config.ts file
TYPE_TS="export type User = {
  name: String;
  email: String;
};"

echo "$TYPE_TS" > "src/type.ts"

