FROM alpine:3.7
MAINTAINER pascalito@gmail.com

ARG HUGO_VERSION
ARG MINIFY_VERSION
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit.tar.gz

# Install HUGO
RUN set -x && \
  apk add --update curl ca-certificates && \
  curl -s -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} | tar -xz hugo -C /usr/bin && \
  curl -s -L https://github.com/tdewolff/minify/releases/download/v${MINIFY_VERSION}/minify_${MINIFY_VERSION}_linux_amd64.tar.gz | tar -xz minify -C /usr/bin && \
  rm /usr/bin/*.md && \
  hugo env && \
  minify --version && \
  rm /var/cache/apk/*
