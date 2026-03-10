
# Stage 1: Build dependencies
FROM node:18 AS builder

# Set working directory
WORKDIR /app

# Copy package files
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy project files
COPY . .

# Build the application (if applicable, e.g. React/Next.js)
# For pure Node.js apps, you can skip this step
# RUN npm run build


# Stage 2: Production image
FROM node:18-alpine AS production

# Set working directory
WORKDIR /app

# Copy only necessary files from builder stage
COPY --from=builder /app/package.json /app/package-lock.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app ./

# Expose application port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]





# original file
# Use Node 18 as parent image
#FROM node:18

# Change the working directory on the Docker image to /app
#WORKDIR /app

# Copy package.json and package-lock.json to the /app directory
#COPY package.json package-lock.json ./

# Install dependencies
#RUN npm install

# Copy the rest of project files into this image
#COPY . .

# Expose application port
#EXPOSE 3000

# Start the application
#CMD npm start

