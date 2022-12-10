ARG BASE_IMAGE_TAG=11.5-slim

FROM debian:${BASE_IMAGE_TAG} as builder

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update -y && apt-get install --no-install-recommends ca-certificates curl gnupg -y && \
    curl -sL https://deb.nodesource.com/setup_16.x > /node16.sh && chmod +x node16.sh

FROM debian:${BASE_IMAGE_TAG}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY --from=builder /node16.sh /node16.sh

RUN /node16.sh && rm -f node16.sh && \
    apt-get update && apt-get upgrade -y && \
    apt-get install --no-install-recommends nodejs && \
    npm install -g npm@latest typescript nodemon && \
    npm cache clean -f