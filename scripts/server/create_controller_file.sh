#!/bin/bash

# Create src/controllers/userController.ts file
CONTROLLER_TS_CONTENT="import { Request, Response } from 'express';
import UserService from '../services/userService';
import {
  createUserHandler,
  deleteUserHandler,
  editUserHandler,
  getUserByIdHandler,
  getUsersHandler,
} from './handlers/userHandlers';

class UserController {
  private userService: UserService;

  constructor() {
    this.userService = new UserService();
  }

  createUser = async (req: Request, res: Response): Promise<void> => {
    await createUserHandler(req, res);
  };

  getUsers = async (req: Request, res: Response): Promise<void> => {
    await getUsersHandler(req, res);
  };

  getUserById = async (req: Request, res: Response): Promise<void> => {
    await getUserByIdHandler(req, res);
  };

  editUser = async (req: Request, res: Response): Promise<void> => {
    await editUserHandler(req, res);
  };

  deleteUser = async (req: Request, res: Response): Promise<void> => {
    await deleteUserHandler(req, res);
  };
}

export default UserController;"

echo "$CONTROLLER_TS_CONTENT" > "src/controllers/userController.ts"
