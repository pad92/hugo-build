FROM golang:1.10-alpine as builder
ARG MINIFY_REPO="github.com/tdewolff/minify"
ARG MINIFY_PACKAGE="cmd/minify"
ARG MINIFY_VERSION="2.3.5"
RUN apk add --no-cache --update \
        git \
        gcc \
        libc-dev \
  && cd /go ; go get -v ${MINIFY_REPO}/${MINIFY_PACKAGE} \
  && cd /go/src/${MINIFY_REPO}/${MINIFY_PACKAGE} ; git checkout tags/v${MINIFY_VERSION} -b v${MINIFY_VERSION} \
  && cd /go ; go get -v -d ${MINIFY_REPO}/${MINIFY_PACKAGE} \
  && cd /go ; CGO_ENABLED=0 go build -ldflags "-X main.Version=${MINIFY_VERSION}" -a -o /go/bin/minify -installsuffix cgo ${MINIFY_REPO}/${MINIFY_PACKAGE} \
  && /go/bin/minify --version

FROM alpine:3.7
COPY --from=builder /go/bin/minify /usr/local/bin/
ARG HUGO_VERSION="0.41"
RUN set -x && \
  apk add --no-cache --update \
        curl \
        ca-certificates \
  && curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz | \
        tar -xz hugo -C /usr/local/bin/

