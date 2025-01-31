#!/usr/bin/env bash

# Exist immediately if a command fails
set -e

# Set the version of PostgreSQL you need to use
POSTGRES_VERSION=17.2

# Check that the Dockerfile exists
if [ ! -f "Dockerfile" ]; then
  echo "Error: Dockerfile not found"
  exit 1
fi

# Download the PostgreSQL source code if not already downloaded
if [ ! -d "postgresql-${POSTGRES_VERSION}" ]; then
  curl -O https://ftp.postgresql.org/pub/source/v${POSTGRES_VERSION}/postgresql-${POSTGRES_VERSION}.tar.gz
  tar -xzf postgresql-${POSTGRES_VERSION}.tar.gz
  rm postgresql-${POSTGRES_VERSION}.tar.gz
fi

if [[ $OSTYPE == 'darwin'* ]]; then
  sed -i '' "s/^ARG POSTGRES_VERSION=.*/ARG POSTGRES_VERSION=${POSTGRES_VERSION}/" Dockerfile
else
  sed -i "s/^ARG POSTGRES_VERSION=.*/ARG POSTGRES_VERSION=${POSTGRES_VERSION}/" Dockerfile
fi

if [ ! -d "data" ]; then
  mkdir data
fi

echo 'Setup complete'
