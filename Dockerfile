FROM alpine:3.7
MAINTAINER pascalito@gmail.com

ARG HUGO_VERSION
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit.tar.gz

# Install HUGO
RUN set -x && \
  apk add --update curl ca-certificates && \
  curl -s -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} | tar -xz -C /usr/bin && \
  curl -s -L https://github.com/tdewolff/minify/releases/download/v2.3.4/minify_2.3.4_linux_amd64.tar.gz | tar -xz -C /usr/bin minify && \
  hugo env && \
  minify --version && \
  rm /var/cache/apk/*
