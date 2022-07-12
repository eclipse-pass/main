#!/bin/bash

# Install PASS specific dependencies before adding the runner
# ./deps.sh

# Change this if you are running a forked version
# of the pass application
PASSORG=${PASSORG-eclipse-pass}

function trust_github()
{
  (ssh -o "StrictHostKeyChecking=no" github.com || true)
}

function install_docker()
{
  echo "installing docker ..." && \
    touch /opt/docker.start && \
    apt-get -y update && \
    apt-get install -y gnupg2 pass docker-compose && \
    (usermod -aG docker githubrunner || true) && \
    mv /opt/docker.start /opt/docker.end && \
    echo "... done installing docker"
}

function install_passdocker()
{
  echo "installing pass-docker ..." && \
    touch /opt/pass-docker.start && \
    mkdir -p /src && \
    (cd /src && \
      git clone git@github.com:${PASSORG}/pass-docker.git && \
      cd pass-docker && \
      git checkout minimal-assets) && \
    mv /opt/pass-docker.start /opt/pass-docker.end && \
    echo "... done installing pass-docker"
}

(echo "installing pass-app deps ..." && \
  touch /opt/pass-app-deps.start  && \
  trust_github && \
  install_docker && \
  install_passdocker && \
  mv /opt/pass-app-deps.start /opt/pass-app-deps.end && \
  echo "... done installing pass-app deps")
