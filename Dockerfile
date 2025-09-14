# # Use Node.js Alpine base image
# FROM node:alpine

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


# ---------- Build stage ----------
FROM node:20-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .

# ---------- Run stage ----------
FROM node:20-alpine

WORKDIR /app
COPY --from=builder /app /app

EXPOSE 3000
CMD ["npm", "start"]


