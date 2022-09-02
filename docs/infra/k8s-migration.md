# Kubernetes Manual Migration

See our [initial attempt](docker-composer-to-k8s-manifest.md) to migrate our Docker compose configuration automatically to a Kubernetes configuration. This automated conversion was used as a starting basis for
the configuration that we now have.

## Test Cluster

We are using the Kubernetes hosting service at [Digital Ocean](https://www.digitalocean.com). This is a
solution to get our k8s configuration figured out with an environment that we have full control over.
Once we have completed the configuration, we will move the configuration to a k8s cluster hosted
by the Eclipse Foundation.

## Creating and Configuring the Cluster

### Prerequisites

1. [Install doctl](https://docs.digitalocean.com/reference/doctl/how-to/install/).
2. [Generate a token](https://cloud.digitalocean.com/account/api/tokens/new) with Digital Ocean.
3. Authenticate with Digital Ocean using the token: `doctl auth init`.
4. [Install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (this is the Kubernetes command line tool)

### Cluster Creation & Configuration

These are the steps to creating and configuring the test cluster:

1. Create the cluster:

    ```bash
    doctl kubernetes cluster create pass-docker \
      --auto-upgrade=true \
      --node-pool "name=passnp;count=2;auto-scale=true;min-nodes=1;max-nodes=3;size=s-2vcpu-4gb" \
      --region tor1
    ```

    The available list of node sizes can be obtained by running 'doctl compute size list'

2. Create a secret for accessing the GitHub Container Registry:

    ```bash
    export GITHUB_USERNAME=MyUsername
    export GITHUB_TOKEN=MyGitHubPersonalAccessToken
    kubectl create secret docker-registry regcred \
      --docker-server=https://ghcr.io \
      --docker-username=GITHUB_USERNAME \
      --docker-password=GITHUB_TOKEN \
    ```

    This secret is referenced in k8s-deployment.yaml.

    Use a personal access token with registry read access.

3. Apply the Kubernetes configuration files found in the [pass-docker](https://github.com/eclipse-pass/pass-docker)
   repo. The list of files and the order they should be run in can be found in the
   [Kubernetes README file](https://github.com/eclipse-pass/pass-docker/tree/main/k8s/README.md).

4. Find the external IP address of the cluster:

    ```bash
    doctl compute load-balancer list \
      --format ID,Name,Created,IP,Status
    ```

    It can take some time before the IP address becomes available, run this command until Status is 'active'

### Deployment Configuration

The yaml files found in the pass-docker `k8s` folder specify the configuration for the PASS Eclipse
kubernetes setup. Each of the services within the PASS ecosystem have a `deployment` which contains
a `pod` which is monitored and will ensure that if the pod fails, it will be restarted. Each pod
is a wrapper for a `container` that is a configured Docker image running a PASS Eclipse service.

The images specified correspond to images pushed to either the Docker Hub oapass repository or the
eclipse-pass GitHub Container Registry (currently done manually).

Another important part of pod configuration is specifying any `persistent volumes` that will be used
by the container. The volumes themselves are configured in their own yaml files.

Most deployments have a corresponding Kubernetes `service` defined that configures access to the
pod through a load balancer. Most of the configuration in the services is specifying the ports to
be used. This will route traffic to those ports to the correct container. If there is any conflict
where multiple containers try to use the same port, an error will occur on container startup and the
container will fail.

### Cluster Deletion

To destroy all resources belonging to the test cluster, run this command:

```bash
doctl kubernetes cluster delete pass-docker --dangerous
```

The `--dangerous` flag tells Kubernetes to delete all resources associated with the cluster
