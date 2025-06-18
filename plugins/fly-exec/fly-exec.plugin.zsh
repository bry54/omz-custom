function fly-exec-java(){
  APP_DIR="$1"
  WORKING_DIR="/usr/src/app"

  docker run -it --rm \
  --name fly-java \
  --hostname fly-java \
  --label com.docker.compose.project=fly-exec \
  -v "$APP_DIR":"$WORKING_DIR" \
  -w "$WORKING_DIR" \
  openjdk:8 \
  /bin/bash
}

function fly-exec-node(){
  APP_DIR="$1"
  WORKING_DIR="/usr/src/app"

  docker run -it --rm \
  --name fly-node \
  --hostname fly-node \
  --label com.docker.compose.project=fly-exec \
  -v "$APP_DIR":"$WORKING_DIR" \
  -w "$WORKING_DIR" \
  node:lts \
  /bin/bash
}

function fly-exec-go(){
  APP_DIR="$1"
  WORKING_DIR="/usr/src/app"

  docker run -it --rm \
  --name fly-golang \
  --hostname fly-golang \
  --label com.docker.compose.project=fly-exec \
  -v "$PWD":"$WORKING_DIR" \
  -w "$WORKING_DIR" \
  golang:1.22 \
  /bin/bash
}

function fly-exec-php(){
  APP_DIR="$1"
  WORKING_DIR="/var/www/html"

  docker run -it --rm \
  --name fly-php \
  --hostname fly-php \
  --label com.docker.compose.project=fly-exec \
  -v "$APP_DIR":"$WORKING_DIR" \
  -w "$WORKING_DIR" \
  -p 8080:80 \
  php:latest \
  /bin/bash
}

function fly-exec-nginx(){
  APP_DIR="$1"
  WORKING_DIR="/usr/share/nginx/html"

  docker run --rm \
  --name fly-nginx \
  --hostname fly-nginx \
  --label com.docker.compose.project=fly-exec \
  -v "$APP_DIR":"$WORKING_DIR":ro \
  -p 8080:80 \
  -d nginx
}

function fly-exec-apache(){
  APP_DIR="$1"
  WORKING_DIR="/usr/local/apache2/htdocs/"

  docker run --rm \
  --name fly-apache \
  --hostname fly-apache \
  --label group=fly-exec \
  -v "$APP_DIR":"$WORKING_DIR":ro \
  -p 8080:80 \
  -d httpd:2.4
}
