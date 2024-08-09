#!/bin/bash

# Create src/controllers/handlers/userHandlers.ts file
HANDLER_TS_CONTENT="import { Request, Response } from 'express';
import UserService from '../../services/userService';

const userService = new UserService();

export const createUserHandler = async (req: Request, res: Response): Promise<void> => {
  try {
    console.log('Request Body:', req.body);
    0;
    const newUser = await userService.createUser(req.body);
    res.status(201).json(newUser);
  } catch (error) {
    res.status(500).json({ message: 'Internal Server Error' });
  }
};

export const deleteUserHandler = async (req: Request, res: Response): Promise<void> => {
  const userId = req.params.userId;
  try {
    const success = await userService.deleteUser(userId);
    if (success) {
      res.status(200).json({ message: 'User deleted successfully' });
    } else {
      res.status(404).json({ message: 'User not found' });
    }
  } catch (error) {
    res.status(500).json({ message: 'Internal Server Error' });
  }
};

export const editUserHandler = async (req: Request, res: Response): Promise<void> => {
  const userId = req.params.userId;
  try {
    const updatedUser = await userService.updateUser(userId, req.body);
    if (updatedUser) {
      res.status(200).json(updatedUser);
    } else {
      res.status(404).json({ message: 'User not found' });
    }
  } catch (error) {
    res.status(500).json({ message: 'Internal Server Error' });
  }
};

export const getUserByIdHandler = async (req: Request, res: Response): Promise<void> => {
  const userId = req.params.userId;
  try {
    const user = await userService.getUserById(userId);
    if (user) {
      res.status(200).json(user);
    } else {
      res.status(404).json({ message: 'User not found' });
    }
  } catch (error) {
    res.status(500).json({ message: 'Internal Server Error' });
  }
};

export const getUsersHandler = async (req: Request, res: Response): Promise<void> => {
  try {
    const users = await userService.getUsers();
    res.status(200).json(users);
  } catch (error) {
    res.status(500).json({ message: 'Internal Server Error' });
  }
};
"

echo "$HANDLER_TS_CONTENT" > "src/controllers/handlers/userHandlers.ts"
