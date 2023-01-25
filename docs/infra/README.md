# PASS Infrastructure

At a high level, PASS is decomposed into the following parts:

![PASS Architecture V1](../assets/architecture/pass-architecture-simple-v2.jpg)

### Infrastructure

The following describes the current PASS Infrastructure.

#### EC2

EC2 virtual machines provide access to internal resources within the AWS VPC.

Learn more about [deploying pass-docker via EC2](ec2.md).

#### ECS

PASS was developed using Docker containers and running within Amazon's ECS infrastructure running as a single task (multiple containers) under 1 service. Future development is expected to transition to using Kubernetes and utilizing Amazon's EKS.

#### RDS

PASS uses a PostgreSQL database instance under RDS to store metadata and system information.

#### Amazon MQ

PASS uses Amazon MQ as a queue to capture publication events that are read and executed by the deposit service.

#### S3

The object storage is within AWS's S3 infrastructure.  In particular,

* Used to store binary data that is managed by OCFL
* Stores deployment configuration

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
| Async Service: deposit services | Docker image, multiple intermediate Docker images (not deployed) | [`pass-deposit-services`](https://github.com/eclipse-pass/pass-deposit-services), [`pass-package-providers`](https://github.com/eclipse-pass/pass-package-providers) (intermediate) | Maven builds intermediate Docker images, [`pass-docker`](https://github.com/eclipse-pass/pass-docker) builds final image |
| Async service: notification services | Docker image  | [`pass-notification-services`](https://github.com/eclipse-pass/pass-notification-services) | Docker image created in [`pass-docker`](https://github.com/eclipse-pass/pass-docker) from Spring Boot JAR created by Maven build in [`pass-notification-services`](https://github.com/eclipse-pass/pass-notification-services), released to Sonatype |
| Sync service: REST API | Docker image (`ghcr.io/eclipse-pass/pass-core-main`) | [`pass-core`](https://github.com/eclipse-pass/pass-core) | Generates an executable JAR |
| Batch service: COEUS | JAR | [`pass-grant-loader`](https://github.com/eclipse-pass/pass-grant-loader) | Task run manually or cron job |
| Batch service: NIHMS loader (formerly NIHMS ETL) | JAR | [`pass-nihms-loader`](https://github.com/eclipse-pass/pass-nihms-loader) | Task run manually or cron job |
| Batch service: Journal loader | JAR | [`pass-journal-loader`](https://github.com/eclipse-pass/pass-journal-loader) | Task run manually or cron job |
| Support: Java client | JAR | [`pass-data-client`](https://github.com/eclipse-pass/pass-support/pass-data-client) | JAR for interacting with objects in the PASS data model over JSON API |

### Production Deployment (Kubernetes)

We will soon be upgrading our initial production instance (which is based on Fedora) to the new PASS architecture described above. Part of this transition will also be to move from ECS to EKS, in order to deploy in a more standardized Kubernetes environment. This will also allow us to explore support for other cloud providers (such as Azure) in the future. We welcome questions, discussion, and pull requests in this area.

## Going Forward

As we move towards an Eclipse Foundation hosted Open-Access PASS there will be changes to the PASS architecture, changes to the infrastructure, and changes to the deployment process. This will be documented here, as well as within our [PASS Development Pipeline](pipeline.md).

## References

* [Deployment Pipeline](pipeline.md)
* [Our attempt to use Komposer to migrate Docker Compose to k8s manifest](docker-composer-to-k8s-manifest.md)
* [Working with GitHub secrets](github-secrets.md)
* [Self-Hosted GitHub Runners](self_hosted_github_runners.md)
* [Eclipse Foundation ops](eclipseops.md)
* [Ansible](ansible.md)
