# Use the official Node.js image from Docker Hub
# It is important to specify the version of node to use during the project. a version earlier or higher than the version currently used could cause unwanted errors.😊😊😊
FROM node:22

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"]
