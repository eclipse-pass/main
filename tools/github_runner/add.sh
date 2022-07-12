#!/bin/bash

# To add your self-hosted runner
# Replace with your GitHub Runner Token
# (change URL to your GitHub organization if you forked the application)
# https://github.com/eclipse-pass/main/settings/actions/runners/new?arch=x64&os=linux
#
# GITHUB_RUNNER_TOKEN=AABBCCDDEEAABBCCDDEEAABBCCDDE \
#   ./add.sh \
#   passapp-dev

# The name/label of the runner
NAME=${1-passapp}

# You must provide this on the command line
GITHUB_RUNNER_TOKEN=${GITHUB_RUNNER_TOKEN-na}

# Change this if you are running a forked version
# of the pass application
PASSORG=${PASSORG-eclipse-pass}

(cd /opt/githubrunner && \
  sudo -u githubrunner ./config.sh \
    --unattended \
    --url https://github.com/${PASSORG}/pass-docker \
    --token $GITHUB_RUNNER_TOKEN \
    --name $NAME \
    --runnergroup default \
    --labels $NAME \
    --work pass-docker \
    --replace && \
  ./svc.sh install githubrunner && \
  ./svc.sh start)
