FROM node:16-alpine AS base

WORKDIR /usr/app

COPY package*.json ./

FROM base AS dependencies

RUN npm install

FROM dependencies AS build
WORKDIR /usr/app

COPY . .

ENV NODE_ENV production

RUN npm run build

RUN rm -r src

FROM build AS runtime

COPY --from=build usr/app/build usr/app/build

CMD ["npx", "serve", "build"]