#!/bin/bash

# Create src/config/db.ts file
APP_TS_CONTENT="import cookieParser from 'cookie-parser';
import cors from 'cors';
import express, { NextFunction, Request, Response } from 'express';
import createError from 'http-errors';
import logger from 'morgan';
import connectDB from './config/db';
import expressServerErrorHandler from './middlewares/expressServerErrorHandler';
import featureFlagMiddleware from './middlewares/featureFlagMiddleware';
import geoLocationMiddleware from './middlewares/geoLocationMiddleware';
import requestLoggingMiddleware from './middlewares/requestLoggingMiddleware';
import UserRoutes from './routes/userRouter';

// Initialize Express application
const app = express();

// Define feature flags
const features = {
  newFeature: true,
  betaFeature: false,
};

// Middleware setup
app.use(cors()); // Enable CORS for all routes
app.use(logger('dev')); // Log HTTP requests
app.use(express.json()); // Parse JSON bodies
app.use(express.urlencoded({ extended: true })); // Parse URL-encoded bodies
app.use(cookieParser()); // Parse cookies

// Custom middleware setup
app.use(requestLoggingMiddleware); // Log requests with unique IDs and response times
app.use(geoLocationMiddleware); // Log geolocation info based on IP address
app.use(featureFlagMiddleware(features)); // Attach feature flags to the request

// Set up routes
app.use('/api', new UserRoutes().getRouter());

// Handle 404 errors - if no route matches
app.use((req: Request, res: Response, next: NextFunction) => {
  next(createError(404)); // Forward to error handler with a 404 error
});

// Handle application errors
app.use((err: any, req: Request, res: Response, next: NextFunction) => {
  // Pass the error to the custom error handler
  next(new expressServerErrorHandler(err.message, err.status || 500));
});

// Final error handler - format the error response
app.use((err: expressServerErrorHandler, req: Request, res: Response) => {
  // Set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // Send the error response
  res.status(err.status || 500).json({ message: err.message });
});

// Connect to the database
connectDB();

export default app;
"

echo "$APP_TS_CONTENT" > "src/app.ts"
