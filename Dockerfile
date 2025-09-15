# # Use Node.js Alpine base image
# FROM node:24-alpine3.20

# # Create and set the working directory inside the container
# WORKDIR /app

# # Copy package.json and package-lock.json to the working directory
# COPY package.json package-lock.json /app/

# # Install dependencies
# RUN npm install

# # Copy the entire codebase to the working directory
# COPY . /app/

# # Expose the port your app runs on (replace <PORT_NUMBER> with your app's actual port)
# EXPOSE 3000

# # Define the command to start your application (replace "start" with the actual command to start your app)
# CMD ["npm", "start"]


# Base image 
FROM node:24-alpine3.20 AS base

WORKDIR /app

# Dependencies install
COPY package*.json ./

#  audit fix
RUN npm install -g npm@latest \
    && npm install -g npx \
    && npm install --legacy-peer-deps \
    && npm audit fix --force

COPY . .

# Production build
RUN npm run build

EXPOSE 3000
CMD ["npm", "start"]



