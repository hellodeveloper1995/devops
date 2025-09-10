FROM node:22-alpine

WORKDIR /app

COPY package*.json ./

# build tools install
RUN apk add --no-cache python3 make g++ \
    && npm ci

COPY . .

EXPOSE 3000

CMD ["npm", "start"]

