#!/bin/bash

# Create src/config/db.ts file
DB_TS_CONTENT="import mongoose from 'mongoose';
import dotenv from 'dotenv';

dotenv.config();

const connectDB = async () => {
  try {
    mongoose.set('strictQuery', true);
    const conn = await mongoose.connect(process.env.MONGODB_URI as string);
    console.log(`MongoDB connected: ${conn.connection.host}`);
  } catch (error) {
    if (error instanceof Error) {
      console.error(`Error: ${error.message}`);
    } else {
      console.error('An unknown error occurred during MongoDB connection');
    }
    process.exit(1);
  }
};

export default connectDB;"

echo "$DB_TS_CONTENT" > "src/config/db.ts"
