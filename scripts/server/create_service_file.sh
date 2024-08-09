#!/bin/bash

# Create src/services/userService.ts file
SERVICE_TS_CONTENT="import userModel, { IUser } from '../models/userModel';

class UserService {
  async getUserById(userId: string): Promise<IUser | null> {
    return await userModel.findById(userId);
  }

  async getUsers(): Promise<IUser[]> {
    return await userModel.find();
  }

  async createUser(userData: IUser): Promise<IUser> {
    const newUser = new userModel(userData);
    return await newUser.save();
  }

  async updateUser(userId: string, updatedUserData: Partial<IUser>): Promise<IUser | null> {
    return await userModel.findByIdAndUpdate(userId, updatedUserData, {
      new: true,
    });
  }

  async deleteUser(userId: string): Promise<boolean> {
    const result = await userModel.findByIdAndDelete(userId);
    return result !== null;
  }
}

export default UserService;"

echo "$SERVICE_TS_CONTENT" > "src/services/userService.ts"

