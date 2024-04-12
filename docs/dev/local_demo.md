# Setting Up a Local Demo System

## Install Docker

The demo application runs on [Docker](https://www.docker.com) and [Docker Compose](https://docs.docker.com/compose/).

Installation instructions for Docker and Docker Compose are available for for Windows, Mac and Linux.

* [Docker on Windows](https://docs.docker.com/desktop/install/windows-install/)
* [Docker on Mac](https://docs.docker.com/desktop/install/mac-install/)
* [Docker on Linux](https://docs.docker.com/desktop/install/linux-install/)
* [Docker Compose on all platforms](https://docs.docker.com/compose/install/)

## Download pass-docker

The demo application is available at [pass-docker](https://github.com/eclipse-pass/pass-docker)
You can download a local copy with git

```bash
git clone git@github.com:eclipse-pass/pass-docker.git
```

Don't forget to the `cd` into the new `pass-docker` directory

```bash
cd pass-docker
```

From here you can `git fetch` the latest code and `git checkout <new branch>` to switch between code branches.

Look at the [pass-docker](https://github.com/eclipse-pass/pass-docker/) documentation for how to use the
`docker-compose` command to start PASS. You can run any [docker compose cli command](https://docs.docker.com/compose/reference/).

## Start Pass

Pull Docker images and start PASS in the background:

```bash
docker compose -f docker-compose.yml -f eclipse-pass.local.yml up -d --no-build --quiet-pull --pull always
```
You will see various containers start. Once the `loader` container has started PASS should be available.

## Open browser

In your browser, navigate to [http://localhost:8080].

![Welcome to PASS](../assets/passapp/welcome_screen.png)

You can click on login and enter `nih-user` / `moo`.

![Login as nih-user / moo](../assets/passapp/login_nih-user_moo.png)

And then you are authenticated and can view the PASS dashboard.

![PASS dashbaord](../assets/passapp/dashboard.png)

## Shutting down the demo

The running demo can be stopped with the following command:

```bash
docker compose -f docker-compose.yml -f eclipse-pass.local.yml down -v
```

This will also delete volumes.

## Troubleshooting

### Cannot connect to the Docker daemon

If you see error like

```
Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
```

Then docker is not running (or possibly not installed).  Refer to the `#Install Docker` section
above.

### Cannot find Dockerfile

If you see an error like

```
failed to solve: rpc error: code = Unknown desc = failed to solve with frontend dockerfile.v0: failed to read dockerfile: open /var/lib/docker/tmp/buildkit-mount2714819657/Dockerfile: no such file or directory
```

It's likely pulling all the images did not complete successfully. Try restarting.
