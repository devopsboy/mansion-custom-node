ARG NODE_BASE_IMAGE_TAG=node16-1.0.0

FROM sanjail/jack:${NODE_BASE_IMAGE_TAG}

WORKDIR /app

COPY . .

RUN npm install && \
    npm run build

CMD [ "sh", "-c", "npm run start" ]