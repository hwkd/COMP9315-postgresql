# COMP9315 PostgreSQL setup using Docker

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Development](#development)
- [Docker Commands](#docker-commands)

## Introduction

Downloading, setting up, and building a PostgreSQL database from source can be a time-consuming and tedious process.
It requires you to install all the necessary dependencies on your machine, cluttering your system with dependencies
you might only use for this course.

By using Docker, you can automate the process of building it from source, make each build consistent, avoid installing
any software on your computer just to build PostgreSQL, and help you easily manage your version of PostgreSQL.

This repository helps you to easily setup PostgreSQL for COMP9315 and manage your builds using Docker.

If you want to make changes to the setup, repository, and any part of it, feel free to fork this repository and make
changes as you see fit.

## Prerequisites

- MacOS or Linux
- Git
- Docker (>= v25.0.0)

## Note for Windows users

This repository is designed to work on MacOS and Linux since the scripts only run on Unix based systems. However, with
some extra steps, you should be able to use this setup on Windows. I don't have a Windows machine so I didn't bother
to test it on Windows, but you should be able to use the Dockerfile and the docker commands to build and run the containers.

## Setup

1. Clone this repository.

```bash
git clone https://github.com/hwkd/COMP9315-postgresql
```

2. Change directory to the cloned repository.

```bash
cd ./COMP9315-postgresql
```

3. Set the postgres version you need to use in the `setup.sh` file, then run the setup script.

```bash
# Update this line in the "setup.sh" file
POSTGRES_VERSION=15.11
```

```bash
# Run the setup script
./setup.sh
```

4. Check that the PostgreSQL Docker image builds successfully.

```bash
# Build the Docker image with the "latest" tag by default
./build.sh
```

5. Start the PostgreSQL container.

```bash
# Start the PostgreSQL container with the "latest" tag by default
./pgstart.sh

# or use "1.0.0" tag
./pgstart.sh 1.0.0
```

6. Kill the PostreSQL container.

```bash
./pgstop.sh
```

## Development

Make changes to the source code in the `postgresql-{version}` directory as you normally would.

When you can want to compile it (run the build), you can do so using `./build.sh` script:

```bash
# Build the Docker image with the "latest" tag by default
./build.sh

# Or build the Docker image with a specific tag
./build.sh v1.0.0
```

This will build PostgreSQL with the changes you have made into a Docker image.
Once this is done and you want to run your PostgreSQL server, you can start a PostgreSQL container.

To start the PostgreSQL container:

```bash
# use the "latest" tag by default
./pgstart.sh

# or use a specific tag
./pgstart.sh v1.0.0
```

To stop the PostgreSQL container.

```bash
./pgstop.sh
```

### `data` directory

The `data` directory is mounted to `/data` directory inside the Docker container, so you can store seed data, query files, and any
other files from your host machine that you want to use inside the PostgreSQL container.

In other words, if you `docker exec -it pg bash` into the container, you will see the contents of the `data` directory
in the `/data` directory.

## Docker Commands

Some helpful Docker commands you might use:

Attach to a running Docker container and get a bash shell:

```bash
# Using the container id
docker exec -it <container_id> bash
# Example
docker exec -it 49a2bfe5e2da bash

# Using the container name
docker exec -it <container_name> bash
# Example
docker exec -it pg bash
```

List Docker images on your machine:

```bash
docker images
```

Remove a Docker image:

```bash
# Using the image id
docker rmi <image_id>

# Using the image name and tag
docker rmi <repo:tag>
```

List Docker containers on your machine:

```bash
# List running containers
docker ps

# List all containers
docker ps -a
```

Stop a Docker container:

```bash
docker stop <container_id>
```

Remove a stopped Docker container:

```bash
docker rm <container_id>
```


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
