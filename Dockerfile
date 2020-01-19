ARG NODE_VERSION=12.14.1

FROM node:${NODE_VERSION} AS builder

WORKDIR /work/
COPY package.json yarn.lock /work/

RUN yarn install --frozen-lockfile

COPY . /work/

RUN yarn build

FROM node:${NODE_VERSION}-slim

WORKDIR /work/
COPY --from=builder /work/.nuxt/ /work/.nuxt/
COPY --from=builder /work/node_modules/ /work/node_modules/
COPY --from=builder /work/package.json /work/

CMD ["yarn", "start"]
