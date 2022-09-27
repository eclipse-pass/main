# Deploy to demo.eclipse-pass.org

Our [demo.eclipse-pass.org](https://demo.eclipse-pass.org) system
is currently not publically available.

## Deploy

From the [pass-docker](https://github.com/eclipse-pass/pass-docker) project
you can view the available [actions](https://github.com/eclipse-pass/pass-docker/actions)
including the [Deploy passdemo action](https://github.com/eclipse-pass/pass-docker/blob/main/.github/workflows/deploy_passdemo.yml)

![pass-docker actions](/docs/assets/demo/passdocker_actions.png)

You can then [run the workflow](https://github.com/eclipse-pass/pass-docker/actions/workflows/deploy_passdemo.yml)

![run workflow](/docs/assets/demo/run_workflow.png)

And watch the deploy.

![deployed actions](/docs/assets/demo/deploy_actions.png)

## Demo Code

The code is located in an (unfortunately) deeply nested structure at

```bash
/opt/githubrunner/pass-docker/pass-docker/pass-docker
```

The deploy will pull the latest code, as shown below

```bash
a2forward@nightly-pass:/opt/githubrunner/pass-docker/pass-docker/pass-docker$ git log -1
commit 3766a8db3faabe4e28d0eb1ac9549d5048ec65b2 (grafted, HEAD -> main, origin/main)
Author: Grant McSheffrey <grant.mcsheffrey@eclipse-foundation.org>
Date:   Wed Sep 21 10:49:42 2022 -0400

    Merge pull request #271 from eclipse-pass/k8s-separation

    Separate Kubernetes changes into new files
```

## Nightly Code

There is also a [nightly action](https://github.com/eclipse-pass/pass-docker/blob/main/.github/workflows/deploy_passnightly.yml)
that will run every night (and on every pull-request merge).

For debugging changes outside of an official deploy, you can
directly manipulate code on the server.  You will need to run as `githubrunner`.

```bash
# SSH into the server
cd /opt/githubrunner/pass-docker/pass-docker/pass-docker
sudo su githubrunner
```

And then you can run the application (if it isn't already)

```bash
docker-compose up
```

Or, perhaps change the branch and run a custom build.

```bash
git fetch
git checkout demo-spike
docker-compose -f demo.yml pull
docker-compose -f demo.yml --env-file .demo_env up
```

And then you can (in a separate terminal) observe the working site

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
