FROM node:10
MAINTAINER Leoni Sandes <leonisandes@gmail.com>

WORKDIR /usr/src/kinesalite-v2

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 4567
ENTRYPOINT [ "node", "cli.js" ]