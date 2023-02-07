# Deploying a demo PASS system

What follows are developer-oriented instructions about our
[GitHub Self-Hosted Runners](https://docs.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners)
connected to [GitHub actions](https://github.com/features/actions)
for automatable deploys of PASS demo system.

For information on actually deploying updates to a _running_ demo system
such as [demo.eclipse-pass.org](https://demo.eclipse-pass.org)
please refer to [Eclipse Foundation infrastructure](eclipseops.md)

## Self-Hosted Demo Code

On a self-hosted server, the code is located in an (unfortunately) deeply nested structure at

```bash
/opt/githubrunner/pass-docker/pass-docker/pass-docker
```

On a [GitHub actions](https://github.com/features/actions) deploy,
the latest code will be available at that location, as shown below.

```bash
a2forward@nightly-pass:/opt/githubrunner/pass-docker/pass-docker/pass-docker$ git log -1
commit 3766a8db3faabe4e28d0eb1ac9549d5048ec65b2 (grafted, HEAD -> main, origin/main)
Author: Grant McSheffrey <grant.mcsheffrey@eclipse-foundation.org>
Date:   Wed Sep 21 10:49:42 2022 -0400

    Merge pull request #271 from eclipse-pass/k8s-separation

    Separate Kubernetes changes into new files
```

## Action Triggers

The [GitHub actions](https://github.com/features/actions) are defined in
[pass-docker/.github/workflows]((https://github.com/eclipse-pass/pass-docker/blob/main/.github/workflows/)
such as our [nightly action](https://github.com/eclipse-pass/pass-docker/blob/main/.github/workflows/deploy_passnightly.yml).

The [nightly action](https://github.com/eclipse-pass/pass-docker/blob/main/.github/workflows/deploy_passnightly.yml)
will run every night (and on every pull-request merge).

## Debugging On The Server

Please ensure the issue is actually related to the deployed environment
and IS NOT reproducible locally.

If you are troubleshooting strange behaviour on a
[GitHub Self-Hosted Runners](https://docs.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners)
then you can directly manipulate the code outside of an official deploy.


For that, first SSH onto that server, and then switch to the `githubrunner` user.

```bash
# SSH into the server
cd /opt/githubrunner/pass-docker/pass-docker/pass-docker
sudo su githubrunner
```

From here, you can run the application (any version of it)

```bash
docker-compose up
```

Please refer to the specifics of the [Eclipse Foundation infrastructure](eclipseops.md)
for the actual commands to run on a specific environment.  For example, this
is the specific script that (currently) runs [demo.eclipse-pass.org](https://demo.eclipse-pass.org)

```
docker-compose -f eclipse-pass.base.yml -f eclipse-pass.demo.yml up
```

For debugging purposes you can also change the branch and run a
specific build (what follows is for demonstration purposes not the
specific commands you want to run)

```bash
git fetch
git checkout demo-spike
docker-compose -f demo.yml pull
docker-compose -f demo.yml --env-file .demo_env up
```

If the application did launch as expected, you should be able to
see the working site (for example using `curl`).

```bash
curl -k https://localhost
```

Which will return something similar to

```html
<html>

<head>
    <title>PASS docker</title>
</head>

<body>
    PASS Docker!

    <p>Apps:</p>
    <ul>
        <li><a href="/app/">Ember - the PASS UI</a></li>
    </ul>

</body>

</html>
```
