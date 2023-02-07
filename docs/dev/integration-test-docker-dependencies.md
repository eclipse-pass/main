**As of August 2022, all images used in ITs have been synced to the same versions: `0.1.0`**. The exception is the Elasticsearch image, which remained at `6.2.3`

## Current Integration Testing Docker Dependencies

Java projects:

| Repo | Docker image |
| ---- | :---- |
| [pass-authz](https://github.com/eclipse-pass/pass-authz) | <ul><li>oapass/activemq:20180618</li><li>oapass/indexer:0.0.15-3.1-SNAPSHOT</li><li>oapass/pass-authz-fcrepo:${project.version}</li><li>docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3</li></ul> |
| [pass-deposit-services](https://github.com/eclipse-pass/pass-deposit-services) | <ul><li>oapass/ftpserver:latest</li><li>oapass/postgres:latest</li><li>oapass/dspace:20200419@sha256:99df12f10846f2a2d62058cf4eef631393d7949a343b233a9e487d54fd82a483</li><li>oapass/fcrepo:4.7.5-3.5@sha256:bb44fff182ace1d0d57372f297cbab8cc04c662db2d10a061213178b7c0c9bba</li><li>docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3</li><li>oapass/indexer-wrapped:latest</li></ul> |
| [pass-doi-services](https://github.com/eclipse-pass/pass-doi-service) | <ul><li>doi-service-its (self-built in project)</li><li>oapass/fcrepo:4.7.5-3.2-2</li><li>docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3</li><li>oapass/indexer@sha256:e51092a9d433219d52207f1ec3f5ea7c652d51f516bcbe9434dae556b921546d</li></ul> | 
| [pass-fcrepo-jms](https://github.com/eclipse-pass/pass-fcrepo-jms) |  |
| [pass-fcrepo-jsonld](https://github.com/eclipse-pass/pass-fcrepo-jsonld) |  |
| [pass-fcrepo-module-auth-rbacl](https://github.com/eclipse-pass/pass-fcrepo-module-auth-rbacl) |  |
| [pass-grant-loader](https://github.com/eclipse-pass/pass-grant-loader) | <ul><li>oapass/fcrepo:4.7.5-3.1-SNAPSHOT</li><li>oapass/indexer:0.0.15-3.1-SNAPSHOT</li><li>docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3</li></ul> |
| [pass-indexer](https://github.com/eclipse-pass/pass-indexer) | <ul><li>oapass/fcrepo:4.7.5-3.2</li><li>docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3</li></ul> |
| [pass-indexer-checker](https://github.com/eclipse-pass/pass-indexer-checker) | <ul><li>oapass/fcrepo:4.7.5-3.5-1</li><li>oapass/indexer:0.0.18-3.4-1</li><li>docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3</li></ul> |
| [pass-java-client](https://github.com/eclipse-pass/pass-java-client) | <ul><li>oapass/fcrepo:4.7.5-3.4</li><li>oapass/indexer:0.0.18-3.4</li><li>docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3</li></ul> |
| [pass-journal-loader](https://github.com/eclipse-pass/pass-journal-loader) | <ul><li>oapass/fcrepo:4.7.5-3.2-5</li></ul> |
| [pass-messaging-support](https://github.com/eclipse-pass/pass-messaging-support) |  |
| [pass-nihms-loader](https://github.com/eclipse-pass/pass-nihms-loader) | <ul><li>oapass/fcrepo:4.7.5-3.2-5</li><li>docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3</li><li>oapass/indexer@sha256:e51092a9d433219d52207f1ec3f5ea7c652d51f516bcbe9434dae556b921546d</li></ul> |
| [pass-notification-services](https://github.com/eclipse-pass/pass-notification-services) | <ul><li>oapass/fcrepo:4.7.5-3.4</li><li>oapass/indexer:0.0.18-3.4</li><li>docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3</li><li>oapass/docker-mailserver:20181105</li><li>oapass/ldap:20200610-jhu</li></ul> |
| [pass-package-providers](https://github.com/eclipse-pass/pass-package-providers) | <ul><li>oapass/deposit-services-providers-its:${project.parent.version}</li><li>oapass/fcrepo@sha256:3e39b01edf56c149279cfc51b647df335c01f9ec38036f1724f337ae35d68fe8</li><li>docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3</li><li>oapass/indexer@sha256:e51092a9d433219d52207f1ec3f5ea7c652d51f516bcbe9434dae556b921546d</li></ul> |

Go projects:

| Repo | Docker image |
| ---- | :---- |
| [pass-metadata-schemas](https://github.com/eclipse-pass/pass-metadata-schemas) | <ul><li>oapass/fcrepo:4.7.5-3.2-5</li><li>oapass/schema-service:latest (built)</li></ul> |
| [pass-download-service](https://github.com/eclipse-pass/pass-download-service) | <ul><li>oapass/fcrepo:4.7.5-3.2-5</li><li>oapass/download-service:latest (built)</li></ul> |
| [pass-policy-service](https://github.com/eclipse-pass/pass-policy-service) | <ul><li>oapass/fcrepo:4.7.5-3.4</li><li>oapass/policy-service:latest (built)</li></ul> |

## Different view on the three major Docker images:

### `oapass/fcrepo`
| Version | Used in |
| --- | --- |
| 4.7.5-3.1-SNAPSHOT | [pass-grant-loader](https://github.com/eclipse-pass/pass-grant-loader) |
| 4.7.5-3.2 | [pass-indexer](https://github.com/eclipse-pass/pass-indexer)
| 4.7.5-3.2-2 | [pass-doi-services](https://github.com/eclipse-pass/pass-doi-service) |
| 4.7.5-3.2-3 | [pass-authz](https://github.com/eclipse-pass/pass-authz) |
| 4.7.5-3.2-5 | [pass-journal-loader](https://github.com/eclipse-pass/pass-journal-loader) <br> [pass-nihms-loader](https://github.com/eclipse-pass/pass-nihms-loader) <br> [pass-metadata-schemas](https://github.com/eclipse-pass/pass-metadata-schemas) <br> [pass-download-service](https://github.com/eclipse-pass/pass-download-service) |
| 4.7.5-3.4 | [pass-java-client](https://github.com/eclipse-pass/pass-java-client) <br> [pass-notification-services](https://github.com/eclipse-pass/pass-notification-services) <br> [pass-package-providers](https://github.com/eclipse-pass/pass-package-providers) <br> [pass-policy-service](https://github.com/eclipse-pass/pass-policy-service) |
| 4.7.5-3.5 | [pass-deposit-services](https://github.com/eclipse-pass/pass-deposit-services) |
| 4.7.5-3.5-1 | [pass-indexer-checker](https://github.com/eclipse-pass/pass-indexer-checker) |

`ospass/pass-authz-fcrepo`: Just used in [pass-authz](https://github.com/eclipse-pass/pass-authz). Built by [pass-authz](https://github.com/eclipse-pass/pass-authz) and based on  `oapass/fcrepo:4.7.5-3.2-3`. See its definition [`pass-authz/pass-authz-integration/src/test/resources/docker/Dockerfile`](https://github.com/eclipse-pass/pass-authz/blob/main/pass-authz-integration/src/test/resources/docker/Dockerfile).

`oapass/fcrepo@sha256:3e39b01edf56c149279cfc51b647df335c01f9ec38036f1724f337ae35d68fe8 === 4.7.5-3.4`

### `docker.elastic.co/elasticsearch/elasticsearch-oss`
All projects use `6.2.3` 🎉

### `oapass/indexer`
| Version | Used in repo |
| --- | --- |
| 0.0.15-3.1-SNAPSHOT | [pass-authz](https://github.com/eclipse-pass/pass-authz) <br> [pass-grant-loader](https://github.com/eclipse-pass/pass-grant-loader) |
| 0.0.18-3.4 | [pass-java-client](https://github.com/eclipse-pass/pass-java-client) <br> [pass-notification-services](https://github.com/eclipse-pass/pass-notification-services) <br> [pass-doi-services](https://github.com/eclipse-pass/pass-doi-service) <br> [pass-nihms-loader](https://github.com/eclipse-pass/pass-nihms-loader) <br> [pass-package-providers](https://github.com/eclipse-pass/pass-package-providers) <br> [pass-deposit-services](https://github.com/eclipse-pass/pass-deposit-services) |
| 0.0.18-3.4-1 | [pass-indexer-checker](https://github.com/eclipse-pass/pass-indexer-checker) |

 `sha256:e51092a9d433219d52207f1ec3f5ea7c652d51f516bcbe9434dae556b921546d === 0.0.18-3.4`

`oapass/indexer-wrapped`: This image is used during ITs in [pass-deposit-services](https://github.com/eclipse-pass/pass-deposit-services) and is built by the project. The image is based on `oapass/indexer:0.0.18-3.4`. See [`pass-deposit-services/deposit-integration/src/test/resources/docker/Dockerfile-indexer`](https://github.com/eclipse-pass/pass-deposit-services/blob/main/deposit-integration/src/test/resources/docker/Dockerfile-indexer) for its definition

---

Relationships for all Docker images, how they are used in various integration tests, and where they are built. Most images are built in `pass-docker` with the exception of four stand-alone services, which are built within their respective code repositories: [`pass-doi-services`](https://github.com/eclipse-pass/pass-doi-service), [`pass-metadata-schemas`](https://github.com/eclipse-pass/pass-metadata-schemas), [`pass-policy-service`](https://github.com/eclipse-pass/pass-policy-service), [`pass-download-service`](https://github.com/eclipse-pass/pass-download-service)

![Docker Image IT dependencies.png](../assets/architecture/Docker%20Image%20IT%20dependencies.png)

Original: https://www.figma.com/file/ibkDXjJ6AkXMpvPvL96gmi/Docker-Image-IT-dependencies?node-id=0%3A1

