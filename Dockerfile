FROM node:18-alpine AS builder
WORKDIR /app
COPY src/package.json src/package-lock.json ./
RUN npm ci

FROM node:18-alpine AS runner
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY src/ .

USER node
EXPOSE 3000
CMD ["node", "app.js"]