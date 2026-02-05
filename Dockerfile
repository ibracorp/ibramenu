# FROM ubuntu:latest
FROM ghcr.io/linuxserver/baseimage-ubuntu:jammy

# set version label
ARG VERSION
ARG CODE_RELEASE
LABEL maintainer="taos15"

ARG DEBIAN_FRONTEND=noninteractive

# add local files
COPY /root /
COPY . /opt/ibracorp/ibramenu/


RUN \
  echo "**** install runtime dependencies ****" && \
  apt-get update && \
  apt-get install -y \
  git \
  jq \
  libatomic1 \
  curl \
  wget \
  ruby \
  ruby-dev \
  net-tools \
  netcat \
  unzip \
  python3-pip \
  gcc \
  python3-dev \
  dos2unix \
  glances \
  tmux \
  zsh \
  mc \
  sudo && \
  gem install mdless --no-document 

## Install Docker
RUN \
  echo "**** Install Docker ****" && \
  apt-get update && \
  apt-get install -y \
  ca-certificates && \
  install -m 0755 -d /etc/apt/keyrings && \
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
  chmod a+r /etc/apt/keyrings/docker.asc && \
  # Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null && \
 apt-get update && \
  apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin 

## overwrite disclaimer and set ibramenu alias
RUN \
  touch /opt/ibracorp/IBRADISCLAIMER && \
  echo "**** Creating Inbramenu alias ****" && \
  echo IBRADISCLAIMER=accepted > /opt/ibracorp/IBRADISCLAIMER && \
  echo "alias ibramenu='sudo /opt/ibracorp/ibramenu/ibramenu.sh'" | tee -a /etc/bash.bashrc > /dev/null && \
  echo "**** clean up ****" && \
  apt-get clean && \
  rm -rf \
  /config/* \
  /opt/ibracorp/ibrainstall.sh \
  /tmp/* \
  /var/lib/apt/lists/* \
  /var/tmp/*

