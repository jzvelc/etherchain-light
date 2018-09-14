FROM node:8.12.0-alpine

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

ARG NODE_ENV
ENV NODE_ENV $NODE_ENV
COPY package.json /usr/src/app/

RUN apk add --no-cache --virtual .build-deps \
  git \
  tar \
  patch \
  xz \
  build-base \
  make \
  file \
  autoconf \
  automake \
  libtool \
  python \
  python-dev \
  && npm install && npm cache clean --force \
  && apk del .build-deps \
  && rm -rf /var/cache/apk/*

COPY . /usr/src/app

CMD [ "npm", "start" ]

EXPOSE 3000
