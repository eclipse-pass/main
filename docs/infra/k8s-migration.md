# Kubernetes Manual Migration

See our [initial attempt](docker-composer-to-k8s-manifest.md) to migrate our Docker compose configuration automatically to a Kubernetes configuration.

## Test Cluster

We are using the Kubernetes hosting service at [Digital Ocean](https://www.digitalocean.com). This is a solution to get our k8s configuration figured
out with an environment that we have full control over. Once we have completed the configuration, we will move the configuration to a k8s cluster hosted
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

    doctl kubernetes cluster create pass-docker \
      --auto-upgrade=true \
      --node-pool "name=passnp;count=2;auto-scale=true;min-nodes=1;max-nodes=3;size=s-2vcpu-4gb" \
      --region tor1
      
    The available list of node sizes can be obtained by running 'doctl compute size list'

2. Create a secret for accessing the GitHub Container Registry:

    kubectl create secret docker-registry regcred \
      --docker-server=https://ghcr.io \
      --docker-username=<GitHub username> \
      --docker-password=<GitHub personal access token> \
        
    This secret is referenced in k8s-deployment.yaml.
    
    Use a personal access token with registry read access.

3. Load the cluster with the pass-docker k8s configuration:

    kubectl apply -f k8s-deployment.yaml
    
    The next section will describe the contents of this file.

4. Expose the cluster to the outside world:

    kubectl expose deployment pass-docker-reg \
      --type=LoadBalancer \
      --port=80 \
      --target-port=80

5. Find the external IP address of the cluster:

    doctl compute load-balancer list \
      --format ID,Name,Created,IP,Status

    It can take some time before the IP address becomes available, run this command until Status is 'active'

### Deployment Configuration

The `k8s-deployment.yaml` specifies most of the configuration for the kubernetes setup. The file specifies a kubernetes
"Deployment". The deployment contains a pod which is monitored and will ensure that if the pod fails, it will be restarted.
The deployment can also specify a number of replicas which should be running at the same time.

The majority of the file is the specification of containers. The containers correspond to the Docker images created for
the different PASS projects.

The images specified correspond to images pushed to the GitHub Container Registry (currently done manually).

The containers also specify the ports they use. This will route traffic to those ports to the correct container. If there
is any conflict where multiple containers try to use the same port, an error will occur on container startup and the
container will fail.

### Cluster Deletion

To destroy all resources belonging to the test cluster, follow these steps:

1. Delete the cluster itself:

    doctl kubernetes cluster delete pass-docker

2. Delete the load balancer:

    doctl compute load-balancer delete <Load balancer ID>

    The load balancer ID can be obtained by running 'doctl compute load-balancer list --format ID,Name,Created,IP,Status'

