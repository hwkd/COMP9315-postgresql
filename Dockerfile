FROM ubuntu:24.10

ARG POSTGRES_VERSION=15.11

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/usr/local/pgsql/bin:${PATH}"
ENV PGDATA="/var/lib/postgresql/data"

RUN apt-get update && apt-get install -y \
    build-essential \
    libreadline-dev \
    zlib1g-dev \
    flex \
    bison \
    libxml2-dev \
    libxslt-dev \
    libssl-dev \
    libxml2-utils \
    xsltproc \
    ccache \
    pkg-config \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY postgresql-${POSTGRES_VERSION} /usr/src/postgresql-${POSTGRES_VERSION}/

WORKDIR /usr/src/postgresql-${POSTGRES_VERSION}
RUN ./configure --prefix=/usr/local/pgsql && \
  make && \
  make install

RUN useradd -r -s /bin/bash postgres && \
  mkdir -p ${PGDATA} && \
  chown -R postgres:postgres ${PGDATA}

USER postgres

RUN initdb

EXPOSE 5432

CMD ["postgres"]
