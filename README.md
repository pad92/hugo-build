# hugo-build

Docker image for building a site with hugo and minify

## Variables

| Variable             | Description             | Default   |
|----------------------|-------------------------|-----------|
| **`HUGO_VERSION`**   | Hugo version to build   | `0.42.2`  |
| **`MINIFY_VERSION`** | Minify version to build | `2.3.5`   |


## Build Exemple

```sh
docker build --pull 
      --build-arg HUGO_VERSION='0.42.2'
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
