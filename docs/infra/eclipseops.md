# Eclipse Foundation Operations

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
