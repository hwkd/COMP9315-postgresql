#!/usr/bin/env bash

TAG=$1
IMAGE_NAME=comp9315_postgres

if [ -z "$TAG" ]; then
  TAG=latest
fi

docker run -dit \
    --name pg \
    -p 5432:5432 \
    -e POSTGRES_USER=postgres \
    -e POSTGRES_PASSWORD=postgres \
    -v comp9315:/var/lib/postgresql/data \
    -v $(pwd)/data:/data \
    $IMAGE_NAME:$TAG
