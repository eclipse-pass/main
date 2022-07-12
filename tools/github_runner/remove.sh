#!/bin/bash

# To remove an installed runner,
# Replace with your GitHub Runner Token
# (change URL to your GitHub organization if you forked the application)
# https://github.com/eclipse-pass/main/settings/actions/runners/new?arch=x64&os=linux
#
# GITHUB_RUNNER_TOKEN=AABBCCDDEEAABBCCDDEEAABBCCDDE ./remove.sh

# You must provide this on the command line
GITHUB_RUNNER_TOKEN=${GITHUB_RUNNER_TOKEN-na}

(cd /opt/githubrunner && \
  ./svc.sh uninstall githubrunner && \
  sudo -u githubrunner ./config.sh remove --token $GITHUB_RUNNER_TOKEN)
