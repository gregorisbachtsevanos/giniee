#!/bin/bash

# Create src/models/userModel.ts file
MODEL_TS_CONTENT="import { Schema, model, Document } from 'mongoose';

interface IUser extends Document {
  name: string;
  email: string;
}

const UserSchema = new Schema<IUser>({
  name: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
});

const userModel = model<IUser>('User', UserSchema);

export default userModel;
export { IUser };"

echo "$MODEL_TS_CONTENT" > "src/models/userModel.ts"

