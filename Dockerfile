
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
