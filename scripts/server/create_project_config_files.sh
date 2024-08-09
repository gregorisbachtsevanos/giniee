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
  "env": {
    "node": true,
    "commonjs": true,
    "es2021": true
  },
  "extends": [
    "eslint:recommended",
    "plugin:node/recommended",
    "plugin:prettier/recommended",
    "airbnb-base"
  ],
  "parserOptions": {
    "ecmaVersion": 12,
    "sourceType": "module"
  },
  "plugins": ["import", "prettier", "node"],
  "rules": {
    "prettier/prettier": [
      "error",
      {
        "singleQuote": true,
        "trailingComma": "es5",
        "semi": true,
        "printWidth": 80,
        "tabWidth": 2
      }
    ],
    "no-console": "warn",
    "no-unused-vars": ["error", { "argsIgnorePattern": "^_" }],
    "consistent-return": "off",
    "no-underscore-dangle": ["error", { "allow": ["_id"] }],
    "import/no-extraneous-dependencies": ["error", { "devDependencies": true }],
    "node/no-unpublished-require": "off",
    "node/no-missing-require": "off"
  },
  "overrides": [
    {
      "files": ["*.test.js", "*.spec.js"],
      "env": {
        "jest": true
      },
      "rules": {
        "no-unused-expressions": "off"
      }
    }
  ]
}'

create_json_file ".eslintrc.json" "$ESLINTRC"

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

# Create Prettier ingore file
PRETTIER_IGNORE='
node_modules
build
coverage
.gitlab-ci.yml
public
'

create_json_file ".prettierignore" "$PRETTIER_IGNORE"

# Create Git ingore file
GIT_IGNORE='
node_modules
dist 

.env.uat
.env.prod
'

create_json_file ".gitignore" "$GIT_IGNORE"

# Create tsconfig.json file
TSCONFIG='{
  "compilerOptions": {
    "target": "ES6",
    "module": "commonjs",
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "moduleResolution": "node",
    "forceConsistentCasingInFileNames": true,
  },
  "include": ["src/**/*.ts"],
  "exclude": ["node_modules"]
}'

create_json_file "tsconfig.json" "$TSCONFIG"

echo "Configuration files created successfully."
