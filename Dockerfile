FROM alpine:3.8
ARG HUGO_VERSION="0.54.0"
LABEL maintainer="pad92" \
      org.label-schema.url="https://github.com/pad92/hugo-build/blob/master/README.md" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.version=$HUGO_VERSION \
      org.label-schema.vcs-url="https://github.com/pad92/hugo-build.git" \
      org.label-schema.vcs-ref=$BUILD_VCSREF \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.description="Hugo, Minify, Git with alpine for you" \
      org.label-schema.schema-version="1.0"

RUN set -x && \
  apk add --no-cache --update \
        curl \
        git \
        optipng \
        jpegoptim \
        ca-certificates \
  && curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz | \
        tar -xz hugo -C /usr/local/bin/
