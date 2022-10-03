# Eclipse Foundation Operations

The following site are managed by the Eclipse Foundation.

| URL | Notes | Status
| --- | --- | --- |
| eclipse-pass.org | Github Pages HTML / CSS | pending
| demo.eclipse-pass.org | Linux + Docker Compose | pending
| nightly.eclipse-pass.org | Linux + Docker Compose | pending

If you are looking for developer-oriented instructions
to help debug an issue with the above, please refer to
[managing our demo servers](/docs/infra/deploy_demo.md) documentation.

## Deployment

### eclipse-pass.org

This is managed with [GitHub Pages](https://pages.github.com)
from the [eclipse-pass.github.io](https://github.com/eclipse-pass/eclipse-pass.github.io) repo.

### demo.eclipse-pass.org

The [demo.eclipse-pass.org](https://demo.eclipse-pass.org) site is deployed
on demand using [GitHub actions](https://github.com/features/actions).
Note that this site is not yet publically available.

The demo system is based on the [pass-docker](https://github.com/eclipse-pass/pass-docker) project
and you can view the available [actions](https://github.com/eclipse-pass/pass-docker/actions)
including the [Deploy passdemo action](https://github.com/eclipse-pass/pass-docker/blob/main/.github/workflows/deploy_passdemo.yml)

#### Publish Via GitHub.com

To publish an update, access the actions page.

![pass-docker actions](/docs/assets/demo/passdocker_actions.png)

You can then [run the workflow](https://github.com/eclipse-pass/pass-docker/actions/workflows/deploy_passdemo.yml)

![run workflow](/docs/assets/demo/run_workflow.png)

And watch the deploy.

![deployed actions](/docs/assets/demo/deploy_actions.png)

#### Locally Run Via Docker Compose

The [demo.eclipse-pass.org](https://demo.eclipse-pass.org) site is
managed using [Docker Compose](https://docs.docker.com/compose/).

To run locally first get a locak copy of [pass-docker](https://github.com/eclipse-pass/pass-docker)
then run it with the following commands

```
cd pass-docker && \
  docker-compose -f eclipse-pass.base.yml -f eclipse-pass.demo.yml pull && \
  docker-compose -f eclipse-pass.base.yml -f eclipse-pass.demo.yml up
```

For more information debugging the deployment to our demo servers
please refer to our [demo deploy documentation](/docs/infra/deploy_demo.md).

### nightly.eclipse-pass.org

The [nightly.eclipse-pass.org](https://demo.eclipse-pass.org) site is deployed
automatically on PR merged (as well as nightly) using [GitHub actions](https://github.com/features/actions).
Note that this site is not yet publically available.

Much like [demo.eclipse-pass.org](https://demo.eclipse-pass.org) the nightly
system is based on the [pass-docker](https://github.com/eclipse-pass/pass-docker) project
and you can view the available [actions](https://github.com/eclipse-pass/pass-docker/actions)
including the [Deploy passdemo action](https://github.com/eclipse-pass/pass-docker/blob/main/.github/workflows/deploy_passdemo.yml)

#### Locally Run Via Docker Compose

The [nightly.eclipse-pass.org](https://nightly.eclipse-pass.org) site is
managed using [Docker Compose](https://docs.docker.com/compose/).

To run locally first get a locak copy of [pass-docker](https://github.com/eclipse-pass/pass-docker)
then run it with the following commands

```
cd pass-docker && \
  docker-compose -f eclipse-pass.base.yml -f eclipse-pass.nightly.yml pull && \
  docker-compose -f eclipse-pass.base.yml -f eclipse-pass.nightly.yml up
```

For more information debugging the deployment to our demo servers
(such as [nightly.eclipse-pass.org](https://nightly.eclipse-pass.org))
please refer to our [demo deploy documentation](/docs/infra/deploy_demo.md).


## Infrastructure

A bootstrapped server [installer](/tools/eclipse_ops/bootstrap)
to run a stand-alone PASS application via the [pass-docker](https://github.com/eclipse-pass/pass-docker)
project

Which will do the following

* Install docker
* Install [github self-hosted runners](/docs/infra/self_hosted_github_runners.md)
* Intall [pass-docker](https://github.com/eclipse-pass/pass-docker)
* Configure [pass docker for a GH runner](/docs/infra/self_hosted_github_runners.md)

To configure the self-hosted runner you will need the GITHUB token,
replacing the `XXX` with the actual token value.

```
GITHUB_RUNNER_TOKEN=XXX
```

Learn more from the [installer script itself](/tools/eclipse_ops/bootstrap).

## Run PASS

To manually run the application, execute

```bash
cd /src/pass-docker && \
  sudo docker-compose pull && \
  sudo docker-compose up
```

If you want to run in the background then use `-d`.

```bash
sudo docker-compose up -d
```