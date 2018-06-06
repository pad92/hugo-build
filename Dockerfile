FROM golang:1.10-alpine as builder

ENV MINIFY_VERSION="v2.3.4"
ENV MINIFY_PACKAGE="github.com/tdewolff/minify/cmd/minify"

RUN apk add --no-cache git gcc libc-dev && \
    go get ${MINIFY_PACKAGE} && \
    git -C ${GOPATH}/src/${MINIFY_PACKAGE} checkout tags/${MINIFY_VERSION} && \
    CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-extldflags "-static" -s -w'  -o /minify github.com/tdewolff/minify/cmd/minify && \
    /minify --version

FROM alpine:3.7

COPY --from=builder /minify /usr/local/bin/

ARG HUGO_VERSION

RUN set -x && \
  apk add --no-cache --update curl ca-certificates && \
  curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz | tar -xz hugo -C /usr/local/bin
