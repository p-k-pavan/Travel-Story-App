# Stage 1: Install dependencies
FROM node:21 AS backendBuilder

WORKDIR /backend

COPY package*.json ./
COPY .env .env

RUN npm install

# Stage 2: Build minimal runtime image
FROM node:21-slim

WORKDIR /backend

# use build stage name (backendBuilder)
COPY --from=backendBuilder /backend ./

# Copy the rest of your application
COPY . .

EXPOSE 8888

CMD ["npm", "start"]
