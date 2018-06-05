FROM alpine:3.7

ARG HUGO_VERSION
ARG MINIFY_VERSION

RUN set -x && \
  apk add --no-cache --update curl ca-certificates && \
  curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz | tar -xz hugo -C /usr/local/bin && \
  curl -L https://github.com/tdewolff/minify/releases/download/v${MINIFY_VERSION}/minify_${MINIFY_VERSION}_linux_386.tar.gz| tar -xz minify -C /usr/local/bin
