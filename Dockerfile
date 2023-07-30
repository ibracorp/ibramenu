FROM ghcr.io/linuxserver/baseimage-ubuntu:jammy

# set version label
ARG BUILD_DATE
ARG VERSION
ARG CODE_RELEASE
LABEL maintainer="taos15"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV HOME="/config"

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
    nano \
    net-tools \
    netcat \
    sudo && \
    gem install mdless && \
  echo "**** install ibramenu ****" && \
  mkdir -p /opt/ibracorp && \
  wget -qO /opt/ibracorp/ibrainstall.sh https://raw.githubusercontent.com/ibracorp/ibramenu/main/ibrainstall.sh && \
  chmod +x /opt/ibracorp/ibrainstall.sh && \
  /opt/ibracorp/ibrainstall.sh && \
  ## overwrite disclaimer
  touch /opt/ibracorp/IBRADISCLAIMER && \
  echo IBRADISCLAIMER=accepted > /opt/ibracorp/IBRADISCLAIMER && \
  echo "**** clean up ****" && \
  apt-get clean && \
  rm -rf \
    /config/* \
    /opt/ibracorp/ibrainstall.sh \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# add local files
COPY /root /
