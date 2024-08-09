#!/bin/bash

# Create src/middlewares/assignRequestIdMiddleware.ts file
ASSIGN_REQUEST_ID_MIDDLEWARE_TS_="import { Request, Response, NextFunction } from 'express';
import { v4 as uuidv4 } from 'uuid';

interface assignRequestIdProps extends Request {
  requestId?: string;
}

const assignRequestIdMiddleware = (req: assignRequestIdProps, res: Response, next: NextFunction) => {
  if (!req.requestId) {
    req.requestId = uuidv4();
  }
  next();
};

export default assignRequestIdMiddleware;"

echo "$ASSIGN_REQUEST_ID_MIDDLEWARE_TST" > "src/middlewares/assignRequestIdMiddleware.ts"

# Create src/middlewares/asyncRoutesErrorHandler.ts file
ASSYNC_ROUTES_ERROR_MIDDLEWARE_TS="import { Request, Response, NextFunction } from 'express';

/**
 * Middleware to handle errors in async route handlers.
 * Wraps the async route handler and catches any errors, passing them to the next error handling middleware.
 * @param fn - Async route handler function.
 * @returns Wrapped async route handler function with error handling.
 */

const asyncRoutesErrorHandler =
  (fn: (req: Request, res: Response, next: NextFunction) => Promise<void>) =>
  (req: Request, res: Response, next: NextFunction) => {
    Promise.resolve(fn(req, res, next)).catch(next);
  };

export default asyncRoutesErrorHandler;"

echo "$ASSYNC_ROUTES_ERROR_MIDDLEWARE_TS" > "src/middlewares/asyncRoutesErrorHandler.ts"

# Create src/middlewares/errorLoggingMiddleware.ts file
ERROR_LOGGING_MIDDLEWARE_TS="import { Request, Response, NextFunction } from 'express';

/**
 * Middleware to handle errors in async route handlers.
 * Wraps the async route handler and catches any errors, passing them to the next error handling middleware.
 * @param fn - Async route handler function.
 * @returns Wrapped async route handler function with error handling.
 */

const asyncRoutesErrorHandler =
  (fn: (req: Request, res: Response, next: NextFunction) => Promise<void>) =>
  (req: Request, res: Response, next: NextFunction) => {
    Promise.resolve(fn(req, res, next)).catch(next);
  };

export default asyncRoutesErrorHandler;"

echo "$ERROR_LOGGING_MIDDLEWARE_TS" > "src/middlewares/errorLoggingMiddleware.ts"

# Create src/middlewares/expressServerErrorHandler.ts file
EXPRESS_SERVER_ERROR_HANDLER_MIDDLEWARE_TS="/**
 * Custom error class for handling server errors.
 * Extends the default Error class with an additional status property.
 */

class expressServerErrorHandler extends Error {
  status: number;

  constructor(message: string, status: number) {
    super(message);
    this.status = status;
  }
}

export default expressServerErrorHandler;"

echo "$EXPRESS_SERVER_ERROR_HANDLER_MIDDLEWARE_TS" > "src/middlewares/expressServerErrorHandler.ts"

# Create src/middlewares/featureFlagMiddleware.ts file
GEATURE_FLAG_MIDDLEWARE_TS="import { Request, Response, NextFunction } from 'express';

declare global {
  namespace Express {
    interface Request {
      features?: { [key: string]: boolean };
    }
  }
}

/**
 * Middleware to add feature flags to the request object.
 * Enables toggling features on and off based on configuration.
 * @param features - Object containing feature flags.
 * @returns Middleware function to add features to request.
 */

const featureFlagMiddleware = (features: { [key: string]: boolean }) => {
  return (req: Request, res: Response, next: NextFunction) => {
    req.features = features;
    next();
  };
};

export default featureFlagMiddleware;"

echo "$GEATURE_FLAG_MIDDLEWARE_TS" > "src/middlewares/featureFlagMiddleware.ts"

# Create src/middlewares/geoLocationMiddleware.ts file
GEO_LOCATION_MIDDLEWARE_TS="import { Request, Response, NextFunction } from 'express';
import geoip from 'geoip-lite';

/**
 * Middleware to log geolocation information based on the requester΄s IP address.
 * Uses the 'geoip-lite' library to lookup geolocation data.
 * Logs the IP address and the corresponding city and country.
 * @param req - Express request object.
 * @param res - Express response object.
 * @param next - Express next function.
 */

const geoLocationMiddleware = (req: Request, res: Response, next: NextFunction) => {
  const ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
  const geo = geoip.lookup(ip as string);
  console.log(`Request from ${ip} - Location: ${geo ? geo.city + ', ' + geo.country : 'Unknown'}`);
  next();
};

export default geoLocationMiddleware;"

echo "$GEO_LOCATION_MIDDLEWARE_TS" > "src/middlewares/geoLocationMiddleware.ts"

# Create src/middlewares/requestLoggingMiddleware.ts file
REQUEST_LOGGING_MIDDLEWARE_TS="import { Request, Response, NextFunction } from 'express';
import { v4 as uuidv4 } from 'uuid';

interface loggingRequestMiddleware extends Request {
  requestId?: string;
}

/**
 * Middleware to log details of incoming requests and responses.
 * Logs request method, URL, headers, and body.
 * Logs response status and response time.
 * @param req - Express request object.
 * @param res - Express response object.
 * @param next - Express next function.
 */

const requestLoggingMiddleware = (
  req: loggingRequestMiddleware,
  res: Response,
  next: NextFunction
) => {
  const requestId = uuidv4();
  req.requestId = requestId;

  const startTime = Date.now();

  const { method, url, headers, body } = req;

  console.log(`[${new Date().toISOString()}] [${requestId}] ${method} ${url}`);
  console.log(`[${requestId}] Headers: ${JSON.stringify(headers)}`);
  console.log(`[${requestId}] Body: ${JSON.stringify(body)}`);

  res.on('finish', () => {
    const responseTime = Date.now() - startTime;
    console.log(`[${new Date().toISOString()}] [${requestId}] Response Status: ${res.statusCode}`);
    console.log(`[${requestId}] Response Time: ${responseTime}ms`);
  });

  next();
};

export default requestLoggingMiddleware;"

echo "$REQUEST_LOGGING_MIDDLEWARE_TS" > "src/middlewares/requestLoggingMiddleware.ts"
