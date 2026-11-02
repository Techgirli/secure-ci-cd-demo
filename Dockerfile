# Stage 1: Build / Install dependencies
FROM node:18-alpine AS builder
WORKDIR /app
COPY src/package.json ./
RUN npm install

# Stage 2: Production runtime image
FROM node:18-alpine AS runner
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY src/ .

USER node
EXPOSE 3000
CMD ["node", "app.js"]