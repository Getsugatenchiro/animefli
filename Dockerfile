# Stage 1: Build the application
FROM node:18.18 as builder

LABEL maintainer="adgsenpai"

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./
RUN npm install --legacy-peer-deps

# Bundle app source
COPY . .

# Build the application
RUN npm run build

# Stage 2: Run the application
FROM node:18.18

WORKDIR /usr/src/app

# Install PM2 globally
RUN npm install pm2 -g
 
# Use non-root user
USER node

# Expose port 8080
EXPOSE 8080

# Define the command to run the app using PM2
CMD ["pm2-runtime", "start", "npm", "--", "run", "start"]