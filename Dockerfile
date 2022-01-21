ARG NODE_VERSION=14.18.2-alpine

# Install dependencies
FROM node:${NODE_VERSION} AS dependencies
WORKDIR /app

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Build strapi
FROM node:${NODE_VERSION} AS builder
WORKDIR /app

ENV NODE_ENV production

COPY . .
COPY --from=dependencies /app/node_modules ./node_modules
RUN yarn build

# Run image
FROM node:${NODE_VERSION} AS runner
WORKDIR /app

ENV NODE_ENV production

COPY --from=builder ./app ./

EXPOSE 1337

CMD ["yarn", "start"]