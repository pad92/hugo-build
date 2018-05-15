FROM alpine:3.7
MAINTAINER pascalito@gmail.com

ARG HUGO_VERSION
ARG MINIFY_VERSION

# Install HUGO
RUN set -x && \
  apk add --update curl ca-certificates && \
  curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz | tar -xz hugo -C /usr/bin && \
  curl -L https://github.com/tdewolff/minify/releases/download/v${MINIFY_VERSION}/minify_${MINIFY_VERSION}_linux_amd64.tar.gz | tar -xz minify -C /usr/bin && \
  hugo env && \
  minify --version && \
  rm /var/cache/apk/*
