FROM golang:1.10-alpine as builder
ENV MINIFY_PACKAGE="github.com/tdewolff/minify/cmd/minify"
RUN apk add --no-cache --update \
        git \
        gcc \
        libc-dev \
  && go get -v -d ${MINIFY_PACKAGE} \
  && CGO_ENABLED=0 go build -a -o /go/bin/minify -installsuffix cgo github.com/tdewolff/minify/cmd/minify \
  && /go/bin/minify --version

FROM alpine:3.7
COPY --from=builder /go/bin/minify /usr/local/bin/
ARG HUGO_VERSION
RUN set -x && \
  apk add --no-cache --update \
        curl \
        ca-certificates \
  && curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz | \
             tar -xz hugo -C /usr/local/bin/

