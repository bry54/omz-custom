function fly-exec-java(){
  APP_DIR="$1"
  WORKING_DIR="/usr/src/app"
  docker run -it --rm \
  --name java-onthe-fly \
  --hostname java-onthe-fly \
  -v "$APP_DIR":"$WORKING_DIR" \
  -w "$WORKING_DIR" \
  openjdk:11 \
  /bin/bash
}

function fly-exec-php(){
  APP_DIR="$1"
  WORKING_DIR="/var/www/html"
  docker run -it --rm \
  --name php-onthe-fly \
  --hostname php-onthe-fly \
  -v "$APP_DIR":"$WORKING_DIR" \
  -w "$WORKING_DIR" \
  -p 8080:80 \
  php:latest \
  /bin/bash
}

function fly-exec-node(){
  APP_DIR="$1"
  WORKING_DIR="/usr/src/app"
  docker run -it --rm \
  --name node-onthe-fly \
  --hostname node-onthe-fly \
  -v "$APP_DIR":"$WORKING_DIR" \
  -w "$WORKING_DIR" \
  node:lts \
  /bin/bash
}