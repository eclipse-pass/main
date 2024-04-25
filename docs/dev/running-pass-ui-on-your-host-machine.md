In order to run pass-ui outside of the docker environment:

1) Configure the docker environment

You will need to configure `pass-core` to load the UI from `localhost:4200`.

This can be done by seting the environment variable `PASS_CORE_APP_LOCATION` to `http://host.docker.internal:4200/app/` in `.env`. This will bypass the `pass-ui` container.

Then simply use docker compose like normal.

```
docker compose -f docker-compose.yml -f eclipse-pass.local.yml <your command here>
```

You may need to investigate other ways of accessing the host machine network, [see](https://docs.docker.com/desktop/networking/#i-want-to-connect-from-a-container-to-a-service-on-the-host).

You may also consider stopping the pass-ui container.

2) Run pass-ui on your host machine 

Start ember on port 4200.

```
ember s 
```

