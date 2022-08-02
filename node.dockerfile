FROM node:18.6.0-alpine3.15
RUN apk add --update bash && rm -rf /var/cache/apk/*
RUN apk add --update git && rm -rf /tmp/* /var/cache/apk/*

WORKDIR /var/www/html
COPY . .

RUN npm install

EXPOSE 5173
CMD ["npm", "run", "dev"]
