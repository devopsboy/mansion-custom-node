ARG NODE_BASE_IMAGE_TAG=node16-1.0.0

FROM sanjail/jack:${NODE_BASE_IMAGE_TAG} AS builder

WORKDIR /app

COPY package*.json .

RUN npm install

COPY . .

RUN npm run build

FROM nginx:1.23.2-alpine

WORKDIR /usr/share/nginx/html

RUN rm -rf ./* && \
    sed -ie "s/user  nginx;/user  1001;/g" '/etc/nginx/nginx.conf'

COPY --from=builder /app/build .
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

RUN apk update && apk upgrade --no-cache && \
    apk --no-cache add dumb-init && \
    rm -rf /var/cache/apk/* && \
    chown -R 1001:0 /usr/share/nginx /var/cache /var/run /var/log/nginx && \
    chmod -R g=u /usr/share/nginx /var/cache /var/run /var/log/nginx

USER 1001

CMD ["dumb-init", "--", "nginx", "-g", "daemon off;"]