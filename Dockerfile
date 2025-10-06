# Step 1: Use Node.js base image
FROM node:18-alpine AS build

# Step 2: Set working directory
WORKDIR /app

# Step 3: Copy dependency files
COPY package*.json ./

# Step 4: Install dependencies (ignore peer dependency conflicts)
RUN npm install --legacy-peer-deps

# Step 5: Copy application code
COPY . .

# Step 6: Build the app
RUN npm run build

# Step 7: Serve with Nginx
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
