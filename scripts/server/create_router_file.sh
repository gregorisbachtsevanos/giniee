#!/bin/bash

# Create src/routes/userRouter.ts file
ROUTER_TS_CONTENT="import { Router } from 'express';
import asyncRoutesErrorHandler from '../middlewares/asyncRoutesErrorHandler';
import UserController from '../controllers/userController';

class UserRoutes {
    public router: Router;
    private userController: UserController;

    constructor() {
        this.router = Router();
        this.userController = new UserController();
        this.initializeRoutes();
    }

    initializeRoutes() {
        this.initializeGetRoutes();
        this.initializePostRoutes();
        this.initializePutRoutes();
        this.initializeDeleteRoutes();
    }

    initializeGetRoutes() {
        this.router.get('/user/get-all-users', asyncRoutesErrorHandler(this.userController.getUsers));
        this.router.get('/user/:userId', asyncRoutesErrorHandler(this.userController.getUserById));
    }

    initializePostRoutes() {
        this.router.post('/user/add-user', asyncRoutesErrorHandler(this.userController.createUser));
    }

    initializePutRoutes() {
        this.router.patch('/user/edit-user/:userId', asyncRoutesErrorHandler(this.userController.editUser));
    }

    initializeDeleteRoutes() {
        this.router.delete('/user/delete-user/:userId', asyncRoutesErrorHandler(this.userController.deleteUser));
    }

    getRouter() {
        return this.router;
    }
}

export default UserRoutes;"

echo "$ROUTER_TS_CONTENT" > "src/routes/userRouter.ts"
