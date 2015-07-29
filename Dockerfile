FROM phusion/baseimage
MAINTAINER Jacob Sanford <jsanford_at_unb.ca>

ENV HUBOT_VERSION=2.6.0

RUN apt-get update && \
  apt-get install -y wget && \
  wget -q -O - https://deb.nodesource.com/setup | sudo bash - && \
  apt-get install -y git build-essential nodejs python && \
  rm -rf /var/lib/apt/lists/* && \
  npm install -g hubot@$HUBOT_VERSION coffee-script

RUN cd /opt && \
  hubot --create myhubot && \
  cd myhubot && \
  npm install hubot-slack --save && \
  npm install && \
  echo '["redis-brain.coffee", "shipit.coffee", "replygif.coffee"]' > hubot-scripts.json

ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run
