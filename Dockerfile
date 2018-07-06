FROM golang:alpine as builder

ARG MINIFY_REPO="github.com/tdewolff/minify"
ARG MINIFY_PACKAGE="cmd/minify"
ARG MINIFY_VERSION="2.3.5"

LABEL maintainer="Pascal A. <pascalito@gmail.com>" \
      org.label-schema.url="https://github.com/pad92/hugo-build/blob/master/README.md" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url="https://github.com/pad92/hugo-build.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.description="Hugo on alpine docker image" \
      org.label-schema.schema-version="1.0"


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
ARG HUGO_VERSION="0.42.2"
RUN set -x && \
  apk add --no-cache --update \
        curl \
        ca-certificates \
  && curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz | \
        tar -xz hugo -C /usr/local/bin/

