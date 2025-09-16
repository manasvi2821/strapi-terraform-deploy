# Use stable Node version for Strapi v4
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy dependency files first
COPY package*.json ./

# Install only production dependencies
RUN npm install --production

# Copy the rest of the application
COPY . .

# Build Strapi admin panel
RUN npm run build

# Set environment variables
ENV NODE_ENV=production
ENV PORT=1337

# Expose Strapi port
EXPOSE 1337

# Start Strapi
CMD ["npm","run", "develop"]