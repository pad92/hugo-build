# hugo-build

[![Layers](https://images.microbadger.com/badges/image/pad92/hugo-build.svg)](https://microbadger.com/images/pad92/hugo-build) [![GitHub issues](https://img.shields.io/github/issues/pad92/docker-hugo-build.svg)](https://github.com/pad92/docker-hugo-build) [![Docker Automated build](https://img.shields.io/docker/automated/pad92/hugo-build.svg?maxAge=2592000)](https://hub.docker.com/r/pad92/hugo-build/) [![Docker Build Status](https://img.shields.io/docker/build/pad92/hugo-build.svg?maxAge=2592000)](https://hub.docker.com/r/pad92/hugo-build/) [![Docker Pulls](https://img.shields.io/docker/pulls/pad92/hugo-build.svg)](https://hub.docker.com/r/pad92/hugo-build/)

Docker image for building a site with hugo and minify

## Variables

| Variable             | Description             | Default   |
|----------------------|-------------------------|-----------|
| **`HUGO_VERSION`**   | Hugo version to build   | `0.43`    |
| **`MINIFY_VERSION`** | Minify version to build | `2.3.5`   |


## Build Exemple

```sh
docker build --pull 
      --build-arg HUGO_VERSION='0.43'
      --build-arg MINIFY_VERSION='2.35'
      -t hugo-build .
```

## Sources and version used by default

### Hugo

https://github.com/gohugoio/hugo/releases

### Minify

https://github.com/tdewolff/minify/tree/v2.3.5/cmd/minify


## Usage

* Build website  
```/usr/local/bin/hugo```

* Minify hugo content  
```/usr/local/bin/minify -r -o public/ public/```

* Publish public/
