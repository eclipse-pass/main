# PASS Infrastructure

The following documents aggregate documentation from Derek Belrose and Aaron Birkland at JHU.

At a high level, PASS is decomposed into the following parts (v1).

![PASS Architecture V1](/docs/assets/architecture/overview_v1.png)

## Detailed Infrastructure

A more detailed deployment view is below.

![PASS Detailed Deployment](/docs/assets/architecture/detail_schematic.png)

### Infrastructure

The following describes the current PASS Infrasture.

#### EC2

EC2 virtual machines provide access to internal resources within the AWS VPC.
Ops and devs can ssh to this server to directly talk to the resources without going through the Load Balancer.

Learn more about [deploying pass-docker via EC2](/docs/infra/ec2.md).

#### ECS

PASS was developed using Docker containers and running within Amazon's ECS infrastructure running as a single task (multiple containers) under 1 service.

#### RDS

PASS uses Fedora Commons repository software and PostgreSQL database instance under RDS to store metadata for fcrepo.

#### Amazon MQ

PASS uses Amazon MQ as a queue that emmits changes that fcrepo makes. It is picked up by the indexer which updates the Elasticsearch index.

#### Amazon Elasticsearch Service

Elasticsearch is an index for the web application to search and find information in fcrepo.

#### S3

The object storage is within AWS's S3 infrastructure.  In particular,

* Used to store binary data for fcrepo
* Stores boot time configuration for some of the docker containers
* Stores current deployment templates for CloudFormation

#### Application Load Balancer

SSL termination and front end for the entire infrastructure. No special rules, just forwards to the ECS service on port 80.

#### Shibboleth

We run a number of Shibboleth service providers, one for each environment.

### Build Artifacts:

| Component | Artifact | Source repo | Notes |
| --- | --- | --- | --- |
| UI | Docker image, Nginx w/web app | Source code from [`pass-ui`](https://github.com/eclipse-pass/pass-ui), artifact created in [`pass-docker`](https://github.com/eclipse-pass/pass-docker) | Includes NPM package we publish from [`pass-emnber-adapter`](https://github.com/eclipse-pass/pass-ember-adapter) |
| Ember assets | Docker image, Nginx | Source code from [`pass-ui-public`](https://github.com/eclipse-pass/pass-ui-public), artifact created in [`pass-docker`](https://github.com/eclipse-pass/pass-docker) |  |
| Apache HTTPd reverse proxy | Docker image, Apache | [`pass-docker`](https://github.com/eclipse-pass/pass-docker) |  |
| Async Service: [`pass-indexer`](https://github.com/eclipse-pass/pass-indexer) | JAR / Docker image | [`pass-indexer`](https://github.com/eclipse-pass/pass-indexer) GH repo. Maven build, file attached to a GH release |  |
| Async Service: deposit services | Docker image, multiple intermediate Docker images (not deployed) | [`pass-deposit-services`](https://github.com/eclipse-pass/pass-deposit-services), [`pass-package-providers`](https://github.com/eclipse-pass/pass-package-providers) (intermediate) | Maven builds intermediate Docker images, [`pass-docker`](https://github.com/eclipse-pass/pass-docker) builds final image |
| Async service: [`pass-authz-listener`](https://github.com/eclipse-pass/pass-authz/tree/main/pass-authz-listener) | Docker image (`authz`) | [`pass-authz/pass-authz-listener`](https://github.com/eclipse-pass/pass-authz/tree/main/pass-authz-listener) | Maven build, release to Maven Central |
| Async service: notification services | Docker image  | [`pass-notification-services`](https://github.com/eclipse-pass/pass-notification-services) | Docker image created in [`pass-docker`](https://github.com/eclipse-pass/pass-docker) from Spring Boot JAR created by Maven build in [`pass-notification-services`](https://github.com/eclipse-pass/pass-notification-services), released to Sonatype |
| Sync service: DOI service | Docker image (`oapass/doi-service`) | [`pass-doi-service`](https://github.com/eclipse-pass/pass-doi-service) | Generates WAR, packaged in Docker image |
| Sync service: Policy service | Docker image (`oapass/policy-service`) | [`pass-policy-service`](https://github.com/eclipse-pass/pass-policy-service) | Generates Go app, packaged in Docker image |
| Sync service: Metadata schema service | Docker image (`oapass/schema-service`) | [`pass-metadata-schemas`](https://github.com/eclipse-pass/pass-metadata-schemas) | Generates Go app, packaged in Docker image  |
| Sync service: Download service | Docker image (`oapass/download-service`) | [`pass-download-service`](https://github.com/eclipse-pass/pass-download-service) | Generates Go app, packaged in Docker image |
| Fedora | Docker image compiles many Java project artifacts | Docker image created in [`pass-docker`](https://github.com/eclipse-pass/pass-docker), other dependnecies: [`pass-authz`](https://github.com/eclipse-pass/pass-authz), [`pass-fcrepo-jms`](https://github.com/eclipse-pass/pass-fcrepo-jms), [`eclipse-pass/modeshape`](https://github.com/eclipse-pass/modeshape) (fork), [`pass-fcrepo-module-rbacl`](https://github.com/eclipse-pass/pass-fcrepo-module-auth-rbacl), [`pass-fcrepo-jsonld`](https://github.com/eclipse-pass/pass-fcrepo-jsonld) | Base `fcrepo` WAR from the Fedora project is unpacked, select pieces added or substituted |
| Batch service: COEUS | JAR | [`pass-grant-loader`](https://github.com/eclipse-pass/pass-grant-loader) | Task run manually or cron job |
| Batch service: NIHMS loader (formerly NIHMS ETL) | JAR | [`pass-nihms-loader`](https://github.com/eclipse-pass/pass-nihms-loader) | Task run manually or cron job |
| Batch service: Journal loader | JAR | [`pass-journal-loader`](https://github.com/eclipse-pass/pass-journal-loader) | Task run manually or cron job |
| Tool: Dupe checker | JAR | [`pass-dupe-checker`](https://github.com/eclipse-pass/pass-dupe-checker) | Run manually |
| Support: Pass messaging support | JAR | [`pass-messaging-support`](https://github.com/eclipse-pass/pass-messaging-support) | Generates three JARs: <br> `org.dataconservancy.pass.support.messaging.*` - `json`, `cri`, `constants` <br> Included in [`pass-deposit-services`](https://github.com/eclipse-pass/pass-deposit-services), [`pass-notification-services`](https://github.com/eclipse-pass/pass-notification-services) |
| Support: Java client | JAR | [`pass-java-client`](https://github.com/eclipse-pass/pass-java-client) | Artifacts for Java projects to interact with the data. Generates JARs: <br> `org.dataconservancy.pass`<br> `pass-json-adpater`, `pass-client-api`, `pass-data-client`, `pass-model`, `pass-status-service` |

## Going Forward

As we move towards an Eclipse Foundation hosted Open-Access PASS there will be
changes to the PASS architecture, changes to the infrasture and the
deployment process.   This will be documented here, as well as within our
[PASS Development Pipeline](/docs/infra/pipeline.md).

### Architecture V2

Our team is looking to replace Fedora is just Postgres, as well
as moving our Data Loaders to integrate with JSON and cloud
storage (e.g. S3).

![PASS Architecture V2](/docs/assets/architecture/overview_v2.png)

### On-Prem Kubernetes Cluster

We are also moving off AWS and onto an on-premise Kubernetes cluster
hosted by the Eclipse Foundation./

## References

* [Deployment Pipeline](/docs/infra/pipeline.md)
* [Our attempt to use Komposer to migrate Docker Compose to k8s manifest](/docs/infra/docker-composer-to-k8s-manifest.md)
* [Working with GitHub secrets](/docs/infra/github-secrets.md)
* [Self-Hosted GitHub Runners](/docs/infra/self_hosted_github_runners.md)