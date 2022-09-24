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

For debugging changes outside of an official deploy, you can
direclty manipulate code on the server.