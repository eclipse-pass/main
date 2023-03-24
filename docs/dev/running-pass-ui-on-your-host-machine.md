In order to run pass-ui outside of the docker environment:

1) run docker compose commands with the local override files:
```
docker compose -f docker-compose.yml -f eclipse-pass.local.yml <your command here>
```
The local override yml and env contain entries relevant to allowing the pass-auth container to access the host machine's network and directing requests to the host machine.

In `eclipse-pass.local.yml` the relevant entry is the `extra_hosts`: 

```
  auth:
    env_file:
      - .eclipse-pass.local_env
    extra_hosts:
      - "host.docker.internal:host-gateway"
```

In `.eclipse-pass.local_env` the relevant env var is `PASS_UI_URL=http://host.docker.internal:4200/`. Note, this will work on a MacOS environment, but may not work on all environments. 

You may need to investigate other ways of accessing the host machine network, [see](https://docs.docker.com/desktop/networking/#i-want-to-connect-from-a-container-to-a-service-on-the-host).

2) run pass-ui on your host machine with a proxy flag:
```
ember s --proxy=http://pass.local
```
