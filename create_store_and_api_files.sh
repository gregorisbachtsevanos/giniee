#!/bin/bash

# Create src/app/store.ts file
STORE_TS_CONTENT='// Example content for store.ts
import { configureStore } from '@reduxjs/toolkit';
import { api } from './services/api';
import { useDispatch } from 'react-redux';

export const store = configureStore({
  reducer: {
    [api.reducerPath]: api.reducer,
  },
  devTools: process.env.NODE_ENV !== 'production',
  middleware: (getDefaultMiddleware) => getDefaultMiddleware().concat(api.middleware),
});

// Infer the `RootState` and `AppDispatch` types from the store itself
export type RootState = ReturnType<typeof store.getState>;
// Inferred type: {posts: PostsState, comments: CommentsState, users: UsersState}
export type AppDispatch = typeof store.dispatch;
export const useAppDispatch: () => AppDispatch = useDispatch;
;'

echo "$STORE_TS_CONTENT" > "src/app/store.ts"


# Create src/app/services/api.ts file
API_TS_CONTENT='// Example content for api.ts
import { createApi, fetchBaseQuery } from "@reduxjs/toolkit/query/react";

/**
 * Create a base API to inject endpoints into elsewhere.
 * Components using this API should import from the injected site,
 * in order to get the appropriate types,
 * and to ensure that the file injecting the endpoints is loaded
 */
export const api = createApi({
	/**
	 * `reducerPath` is optional and will not be required by most users.
	 * This is useful if you have multiple API definitions,
	 * e.g. where each has a different domain, with no interaction between endpoints.
	 * Otherwise, a single API definition should be used in order to support tag invalidation,
	 * among other features
	 */
	reducerPath: "path",
	/**
	 * A bare bones base query would just be `baseQuery: fetchBaseQuery({ baseUrl: '/' })`
	 */
	baseQuery: fetchBaseQuery({ baseUrl: "http://localhost:3001/" }),
	/**
	 * Tag types must be defined in the original API definition
	 * for any tags that would be provided by injected endpoints
	 */
	tagTypes: [],
	/**
	 * This api has endpoints injected in adjacent files,
	 * which is why no endpoints are shown below.
	 * If you want all endpoints defined in the same file, they could be included here instead
	 */
	endpoints: () => ({}),
});
;'

echo "$API_TS_CONTENT" > "src/app/services/api.ts"
