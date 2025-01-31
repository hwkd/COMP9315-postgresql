#!/usr/bin/env bash

# Usage:
#  ./build.sh [tag]
#
#  Examples:
#  ./build.sh
#  ./build.sh v1.0.0
#  ./build.sh 1.0.0
#  ./build.sh test
#  ./build.sh latest

if [ $# -gt 1 ]; then
  echo "Error: Too many arguments. Usage: $0 [tag]"
  exit 1
fi

TAG=$1
IMAGE_NAME=comp9315_postgres

if [ -z "$TAG" ]; then
  TAG=latest
fi

if ! [[ "$TAG" =~ ^[a-z0-9_.-]+$ ]]; then
  echo "Error: Invalid tag format. Use lowercase letters, numbers, underscores, periods, or hyphens."
  exit 1
fi

docker build -t "$IMAGE_NAME:$TAG" .
