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

## Going Forward

As we move towards an Eclipse Foundation hosted Open-Access PASS there will be
changes to the PASS architecture, changes to the infrasture and the
deployment process.   This will be documented here, as well as within our
[PASS Development Pipeline](/docs/pipeline.md).

### Architecture V2

Our team is looking to replace Fedora is just Postgres, as well
as moving our Data Loaders to integrate with JSON and cloud
storage (e.g. S3).

![PASS Architecture V2](/docs/assets/architecture/overview_v1.png)

### On-Prem Kubernetes Cluster

We are also moving off AWS and onto an on-premise Kubernetes cluster
hosted by the Eclipse Foundation./





