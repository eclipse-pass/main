#!/bin/bash

# Install GitHub Runner on your self-hosted server
# ./install.sh

# To get the latest GitHub Runner version, visit
# (change URL to your GitHub organization if you forked the application)
# https://github.com/eclipse-pass/main/settings/actions/runners/new?arch=x64&os=linux
GITHUB_RUNNER_VERSION=2.294.0
GITHUB_RUNNER_CHECKSUM="a19a09f4eda5716e5d48ba86b6b78fc014880c5619b9dba4a059eaf65e131780"

function install_githubrunner()
{
  echo "installing githubrunner ..." && \
    touch /opt/githubrunner.start && \
    rm -rf /opt/githubrunner && \
    mkdir /opt/githubrunner && \
    (useradd githubrunner || true) && \
    (usermod -aG docker githubrunner || true) && \
    (cd /opt/githubrunner && \
     curl -o actions-runner-linux-x64-${GITHUB_RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${GITHUB_RUNNER_VERSION}/actions-runner-linux-x64-${GITHUB_RUNNER_VERSION}.tar.gz && \
     echo "${GITHUB_RUNNER_CHECKSUM}  actions-runner-linux-x64-${GITHUB_RUNNER_VERSION}.tar.gz" | shasum -a 256 -c && \
     tar xzf ./actions-runner-linux-x64-${GITHUB_RUNNER_VERSION}.tar.gz) && \
    chown -R githubrunner:githubrunner /opt/githubrunner && \
    mv /opt/githubrunner.start /opt/githubrunner.end && \
    echo "... done installing githubrunner"
}

(echo "installing GitHub Runner ..." && \
  touch /opt/github-runner.start  && \
  install_githubrunner && \
  mv /opt/github-runner.start /opt/github-runner.end && \
  echo "... done installing github-runner")
