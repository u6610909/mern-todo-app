# Use a lightweight Node.js image (Required by rubric)
FROM node:18-alpine

# Set the working directory
WORKDIR /app

# Copy the entire project into the container
COPY . .

# 1. Build the frontend
WORKDIR /app/TODO/todo_frontend
RUN npm install
RUN npm run build

# 2. Move the frontend build to the backend folder
RUN mkdir -p ../todo_backend/static
RUN mv build ../todo_backend/static/

# 3. Setup the backend
WORKDIR /app/TODO/todo_backend
RUN npm install

# 4. Environment and Execution
EXPOSE 5000
CMD ["npm", "start"]