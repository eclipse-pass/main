# Migrating from Docker Compose to k8s Manifest.

The [docker-pass](https://github.com/eclipse-pass/pass-docker) is orchestrated using
[Docker Compose](https://docs.docker.com/compose/).  The team is now moving towards
[kubernetes](https://kubernetes.io) and this article documents our attempt to
convert our `docker-compose.yml` into [Kubernetes configuration files](https://github.com/eclipse-pass/pass-docker/tree/main/k8s/).

The migration was started with an automated tool named [Kompose](https://kompose.io)
and then has continued with a manual effort.

## Migration Scripts

The following instructions are repo specific for migrating the
docker-compose.yml into k8s-maniftest.yml.  Should we decide to
drop support for docker-compose then consider dropping this section
but keeping the generic documentation below.

### Pass-Docker

From

```bash
USER_SERVICE_URL=pass.local \
  docker-compose config | \
  tail -n +2 > docker-compose-k8s.yaml && \
  kompose convert -f docker-compose-k8s.yaml
```

## Instructions

This will outline various techniques to help convert a docker-compose.yml
file into a k8s-manifest.yml.

We are using [Kompose](https://kompose.io)
to help with the migration.

```bash
brew install kompose
```

From there, locate your `docker-compose.yml` file,
for example, [docker-pass](https://github.com/eclipse-pass/pass-docker/blob/main/docker-compose.yml)
and then run

```bash
docker-compose config > docker-compose-k8s.yaml # if you have a .env file
kompose convert -f docker-compose-k8s.yaml
```

Kompose does not handle .env files so we will want to resolve that first.

## Troubleshooting

### array items[0,1] must be unique

You might see an error like

```
FATA services.fcrepo.ports array items[0,1] must be unique
```

Then most likely you need to _realize_ your docker-compose file
to ensure that your `.env` variables are properly considered
[as kompose does not do that for you](https://github.com/kubernetes/kompose/issues/1164)


### 'Ports': No port specified: :<empty>

Another error you might see

```
* error decoding 'Ports': No port specified: :<empty>
```

See above, as [kompose does not handle a .env file](https://github.com/kubernetes/kompose/issues/1164)

### WARN[0000] The "XXXX" variable is not set.

If you see an error about missing environment variables like

```bash
WARN[0000] The "USER_SERVICE_URL" variable is not set. Defaulting to a blank string.
```

Then when consider adding them to your config converter, for example.

```bash
USER_SERVICE_URL=pass.local \
  docker-compose config > docker-compose-k8s.yaml
```

### cannot unmarshal !!str `pass-do...` into config.RawService

The `docker-compose config` might add an invalid `name: xxx` attributes,
so we will just throw it out

```bash
docker-compose config | \
  tail -n +2 > docker-compose-k8s.yaml
```

## Post-Conversion

These are issues found after using Kompose to convert the docker-compose configuration into
Kubernetes manifests.

### No external IP

The service created for the httpd proxy container is generated to expose ports 80 and 443 within
the cluster instead of making those ports accessible publicly.

To fix this, I modified `proxy-service.yaml` to set the service `type` to `LoadBalancer`.

### Persistent Volume Claim remains stuck in Pending state

Run `kubectl describe pvc` to see the associated errors. If you see an OutOfRange warning then
it should have a description that tells you the minimum supported volume size ('1Gi' for me).

I updated all persistent volume claims to use 1Gi for storage.

### Persistent Volume not found

Some deployments require that a persistent volume be in place prior to their creation (e.g., assets-deployment).

## Reference

* [Translate a Docker Compose File to Kubernetes Resources](https://kubernetes.io/docs/tasks/configure-pod-container/translate-compose-kubernetes/)