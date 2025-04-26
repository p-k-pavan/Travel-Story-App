# Stage 1: Install dependencies
FROM node:21 AS frontendBuilder

WORKDIR /frontend

COPY package*.json ./
COPY .env .env

RUN npm install

# Stage 2: Runtime image
FROM node:21-slim

WORKDIR /frontend

# Copy installed node_modules and env, etc.
COPY --from=frontendBuilder /frontend ./

# Copy remaining project files (excluding ignored ones)
COPY . .

EXPOSE 5173

CMD ["npm", "run", "dev", "--", "--host"]
