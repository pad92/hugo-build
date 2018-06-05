FROM golang:1.9.6-alpine

# https://github.com/gohugoio/hugo/releases
ARG HUGO_VERSION

# Install HUGO
RUN set -x && \
  apk add --no-cache --update \
          curl \
          ca-certificates \
          git && \
  curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz | tar -xz hugo -C /usr/local/bin

# Install Minify
RUN go get -v -d github.com/tdewolff/minify/cmd/minify && \
    CGO_ENABLED=0 go build -a -o /usr/local/bin/minify -installsuffix cgo github.com/tdewolff/minify/cmd/minify && \
    rm -fr src/

# Install Brotli
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk --update add --no-cache brotli