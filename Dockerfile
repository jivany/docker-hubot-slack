FROM phusion/baseimage
MAINTAINER Jacob Sanford <jsanford_at_unb.ca>

ENV HUBOT_VERSION 2.16.0
ENV HUBOT_NAME Hubot
ENV HUBOT_PATH /opt/$HUBOT_NAME
ENV HUBOT_USER yeoman
ENV HUBOT_OWNER="Bot Wrangler <bw@example.com>"
ENV HUBOT_DESCRIPTION="Delightfully aware robutt"
ENV HUBOT_SCRIPTS="'redis-brain.coffee', 'shipit.coffee', 'replygif.coffee'"

# Install yeoman and required dependencies
RUN apt-get update && \
  apt-get install -y wget && \
  wget -q -O - https://deb.nodesource.com/setup | sudo bash - && \
  apt-get install -y git build-essential nodejs python && \
  npm install -g coffee-script yo generator-hubot

# Add a yeoman user
RUN adduser --disabled-password --gecos "" ${HUBOT_USER} && \
  echo "${HUBOT_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Create the app dir
RUN mkdir -p ${HUBOT_PATH} && \
  chown ${HUBOT_USER} ${HUBOT_PATH}

# Use yeoman to provision hubot
USER yeoman
RUN cd ${HUBOT_PATH} && \
  yo hubot --owner="${HUBOT_OWNER}" --name="${HUBOT_USER}" --description="${HUBOT_DESCRIPTION}" --adapter=slack  && \
  echo "[{$HUBOT_SCRIPTS}]" > hubot-scripts.json

# Add phusion/baseimage service
USER root
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run

# Tidy-up
RUN apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
