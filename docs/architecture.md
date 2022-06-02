# PASS Architecture

The following documents aggregate documentation from Derek Belrose and Aaron Birkland at JHU.

At a high level, PASS is decomposed into the following parts (v1).

![PASS Architecture V1](/docs/assets/architecture/overview_v1.png)

## Detailed Infrastructure

A more detailed deployment view is below.

![PASS Detailed Deployment](/docs/assets/architecture/detail_schematic.png)

### Infrastructure

The following describes the current PASS Infrasture.

#### EC2

We are using EC2 virtual machine providing access to internal resources within the AWS VPC. Ops and devs can ssh to this server to directly talk to the resources without going through the Load Balancer.

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

=== Notes ===

* UI: Docker image, Nginx w/web app
* Ember assets: Docker image, Nginx w/web app
* Apache HTTPd reverse proxy: `pass-docker`, Docker image, Apache server
* pass-authz-listener (`pass-authz/pass-authz-listener`, Maven build, Maven Central release)
* pass-indexer: JAR; Maven build, file attached to GH release. Included in a Docker image (`pass-docker`)
* deposit services, ultimately a single image, composed of several intermediate images:
  * Maven creates a set of Docker images for package providers, deposit services core
  * `pass-docker` pulls these images together into a new image
* "Fedora": Docker image, Tomcat server. Uses base Fedora WAR file from Maven central (`https://repo1.maven.org/maven2/org/fcrepo/fcrepo-webapp-plus/${FCREPO_VERSION}/fcrepo-webapp-plus-${FCREPO_VERSION}.war`), then replaces pieces inside the WAR 
  * "Authorization" handled by authz/ACL dependencies
  * jsonld-addon-filters-${JSONLD_ADDON_VERSION}-shaded.jar (`pass-fcrepo-jsonld` repo, Maven build and release to Maven Central)
  * pass-authz-core-${PASS_AUTHZ_VERSION}-shaded.jar (`pass-authz/pass-authz-core`, Maven build and release to Maven Central)
  * pass-authz-roles-${PASS_AUTHZ_VERSION}.jar (`pass-authz/pass-user-roles`, release to Maven Central)
  * pass-user-service.war (`pass-authz/pass-user-service` Maven build and Maven Central release)
  * jms-addon-${JMS_ADDON_VERSION}.jar (`pass-fcrepo-jms`, Maven build, file attached to GH release)
  * modeshape-jcr-5.4.0.Final.jar (from `eclipse-pass/modeshape`, Maven build, file attached to GH release)
    - Contains a single bug fix, not actively developed/maintained, so no automation
  * fcrepo-auth-roles-common.4.7.5-fixes-01.jar (`pass-fcrepo-module-rbacl`, file attached to GH release)

===  ===

_I don't have much insight on the workings of the deployed/production infrastructure, which from my understanding is different from our local dev environment created in `pass-docker`_

| Component | Artifact | Source repo | Notes |
| --- | --- | --- | --- |
| UI | Docker image, Nginx w/web app | Source code from `pass-ui`, artifact created in `pass-docker` | Includes NPM package we publish from `pass-emnber-adapter` |
| Ember assets | Docker image, Nginx | Source code from `pass-ui-public`, artifact created in `pass-docker` |  |
| Apache HTTPd reverse proxy | Docker image, Apache | `pass-docker` |  |
| Async Service: `pass-indexer` | JAR / Docker image | `pass-indexer` GH repo. Maven build, file attached to a GH release |  |
| Async Service: deposit services | Docker image, multiple intermediate Docker images (not deployed) | `pass-deposit-services`, `pass-package-providers` (intermediate) | Maven builds intermediate Docker images, `pass-docker` builds final image |
| Async service: `pass-authz-listener` | Docker image (`authz`) | `pass-authz/pass-authz-listener` | Maven build, release to Maven Central |
| Fedora | Docker image compiles many Java project artifacts | Docker image created in `pass-docker`, other dependnecies: `pass-authz`, `pass-fcrepo-jms`, `eclipse-pass/modeshape` (fork), `pass-fcrepo-module-rbacl`, `pass-fcrepo-jsonld` | Base `fcrepo` WAR from the Fedora project is unpacked, select pieces added or substituted |
| Batch service: COEUS | Executable JAR | `pass-grant-loader` | Task run manually or cron job |
| Batch service: NIHMS loader (formerly NIHMS ETL) | Executable JAR | `pass-nihms-loader` | Task run manually or cron job |


## Going Forward

As we move towards an Eclipse Foundation hosted Open-Access PASS there will be
changes to the PASS architecture, changes to the infrasture and the
deployment process.   This will be documented here, as well as within our
[PASS Development Pipeline](/docs/deploy/pipeline.md).

### Architecture V2

Our team is looking to replace Fedora is just Postgres, as well
as moving our Data Loaders to integrate with JSON and cloud
storage (e.g. S3).

![PASS Architecture V2](/docs/assets/architecture/overview_v2.png)

### On-Prem Kubernetes Cluster

We are also moving off AWS and onto an on-premise Kubernetes cluster
hosted by the Eclipse Foundation./





