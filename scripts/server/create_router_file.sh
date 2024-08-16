#!/bin/bash

# Create src/router/userRouter.ts file
ROUTER_TS_CONTENT="import { Router } from "express";
import asyncErrorHandler from "../utils/asyncErrorHandler";
import UserController from "../controllers/userController";

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
        this.router.get("/user/get-all-users", asyncErrorHandler(this.userController.getUsers));
        this.router.get("/user/:userId", asyncErrorHandler(this.userController.getUserById));
    }

    initializePostRoutes() {
        this.router.post("/user/add-user", asyncErrorHandler(this.userController.createUser));
    }

    initializePutRoutes() {
        this.router.patch("/user/edit-user/:userId", asyncErrorHandler(this.userController.editUser));
    }

    initializeDeleteRoutes() {
        this.router.delete("/user/delete-user/:userId", asyncErrorHandler(this.userController.deleteUser));
    }

    getRouter() {
        return this.router;
    }
}

export default UserRoutes;"

echo "$ROUTER_TS_CONTENT" > "src/router/userRouter.ts"
