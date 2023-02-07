# PASS Digital Ocean Deployment

This will document how to run PASS in [Digital Ocean](https://www.digitalocean.com)
as [Self-Hosted GitHub Runners](self_hosted_github_runners.md).

## Create Server

You will first need a
[linux server as your base OS](https://docs.digitalocean.com/products/droplets/how-to/create/)
with [sudo privileges](https://en.wikipedia.org/wiki/Sudo).

Going forward, the following scripts will be RUN ON THE SERVER, for example
after you SSH into the box.

```bash
ssh <IP>
```

## Install PASS Dependencies

On the server, you will need [docker / docker-compose](https://docs.docker.com/compose/) and [pass-docker](https://github.com/eclipse-pass/pass-docker)

The following script will install those dependencies (these should be run as [sudo](https://en.wikipedia.org/wiki/Sudo))

```bash
apt-get -y update
apt-get install -y gnupg2 pass docker-compose
mkdir -p /src
cd /src
git clone git@github.com:eclipse-pass/pass-docker.git
cd pass-docker
git checkout minimal-assets
```

Or, you can run this directly on your server

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/eclipse-pass/main/main/tools/github_runner/deps.sh)"
```

If the installation worked, then you can pull and run the application

```bash
cd /src/pass-docker && \
  docker-compose pull && \
  docker-compose up
```

## Install GitHub Runner Scripts

If you also wanted to use this server as a
[self-Hosted GitHub Runners software](self_hosted_github_runners.md)
then run

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/eclipse-pass/main/main/tools/github_runner/install.sh)"
```

## Connect Server to GitHub Runner

You can then connect the server to GitHub using the following variables

```bash
PASSORG=eclipse-pass
GITHUB_RUNNER_TOKEN=ghp_abc123def456abc123def456abc123def456
````

To execute the following script.

```bash
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
```

These scripts to [add.sh](/tools/github_runner/add.sh)
and [remove.sh](/tools/github_runner/remove.sh)
your server from GitHub Runner
are available in [/tools/github_runner](/tools/github_runner).

