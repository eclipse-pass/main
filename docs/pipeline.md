# PASS Pipeline

This will document the progression from source code commits to
a production running application.

| Project | Build | Tests | Deploy | Notes |
| --- | --- | --- | --- | --- |
| [pass-authz](https://github.com/eclipse-pass/pass-authz) | ❓ | ❓ | ❓ | Working on running tests and making deployable entity |
| [pass-data-model](https://github.com/eclipse-pass/pass-data-model) | ❓ | ❓ | ❓ | `JSON-LD` [contexts](https://oa-pass.github.io/pass-data-model/src/main/resources/context.jsonld) | URLs need updating to eclipse-pass |
| [pass-ui](https://github.com/eclipse-pass/pass-ui) | ❓ | ❓ | ❓ | The user interface written in Ember |
| [pass-ui-public](https://github.com/eclipse-pass/pass-ui-public) | ❓ | ❓ | ❓ | Holds most of the static assets used by the [pass-ui](https://github.com/eclipse-pass/pass-ui) |
| [pass-ember-adapter](https://github.com/eclipse-pass/pass-ember-adapter) | ❓ | ❓ | ❓| Adapter for interacting with the Fedora repository |
| [pass-indexer](https://github.com/eclipse-pass/pass-indexer) | ❓ | ❓ | ❓ | The pass-indexer keeps an Elasticsearch index up to date with resources in a Fedora repository.
| [pass-policy-service](https://github.com/eclipse-pass/pass-policy-service) | ❓ | ❓ | ❓ | HTTP API for determining the policies applicable to a given Submission
| [pass-docker-mailserver](https://github.com/eclipse-pass/pass-docker-mailserver) | ❓ | ❓ | ❓ | This fork of docker-mailserver is purpose-built to support integration testing of PASS components
| [pass-metadata-schemas](https://github.com/eclipse-pass/pass-metadata-schemas) | ❓ | ❓ | ❓ | JSON schemas and example data intended to describe PASS submission metadata
| [pass-download-service](https://github.com/eclipse-pass/pass-download-service) | ❓ | ❓ | ❓ | PASS download service
| [pass-notification-services](https://github.com/eclipse-pass/pass-notification-services) | ❓ | ❓ | ❓ | Notification Services (NS) reacts to SubmissionEvent messages emitted by the Fedora repository by composing and dispatching notifications in the form of emails to the participants related to the event.
| [pass-doi-service](https://github.com/eclipse-pass/pass-doi-service) | ❓ | ❓ | ❓ | Service for accepting a DOI and returning a Journal ID and Crossref metadata for the DOI
| [pass-deposit-services](https://github.com/eclipse-pass/pass-deposit-services) | ❓ | ❓ | ❓ | Deposit Services are responsible for the transfer of custodial content and metadata from end users to repositories.
| [pass-indexer-checker](https://github.com/eclipse-pass/pass-indexer-checker) | ❓ | ❓ | ❓ | A simple check of the indexer before kicking off a push for a loader
| [pass-dupe-checker](https://github.com/eclipse-pass/pass-dupe-checker) | ❓ | ❓ | ❓ | Traverses a Fedora repository containing PASS resources, and for each resource, determines if a duplicate exists

There are a few additional project that help support Eclipse PASS but are not
part of the core application.

| Project | Notes |
| --- | --- |
| [pass-docker](https://github.com/eclipse-pass/pass-docker) | The canonical environment for demonstrating integration of the [PASS UI application](https://github.com/eclipse-pass/pass-ui)
| [playground](https://github.com/eclipse-pass/playground) | An collection of small hello-world like applications written in the technologies being used with eclipse-pass so that we can isolate, build, deploy and troubleshoot ops procedures separate from issues with the underlying projects. |
| [pass-java-client](https://github.com/eclipse-pass/pass-java-client) | Java client for managing interactions with the PASS data in Fedora.
| [pass-messaging-support](https://github.com/eclipse-pass/pass-messaging-support) | N/A
| [pass-package-providers](https://github.com/eclipse-pass/pass-package-providers) | N/A

The following application help load data into PASS

| Project | Notes |
| --- | --- |
| [pass-nihms-loader](https://github.com/eclipse-pass/pass-nihms-loader) | The NIHMS Submission ETL contains the components required to download, transform and load Submission information from NIHMS to PASS.
| [pass-grant-loader](https://github.com/eclipse-pass/pass-grant-loader) | This project is comprised of code for retrieving grant data from some kind of data source, and using that data to update the PASS backend.
| [pass-journal-loader](https://github.com/eclipse-pass/pass-journal-loader) | Parses the PMC type A journal .csv file, and/or the medline database .txt file, and syncs with the repository

The following repositories have been forked from others

| Project | Forked From | Reason For Fork |
| ---
| [modeshape](https://github.com/eclipse-pass/modeshape) | [ModeShape](https://github.com/ModeShape/modeshape) | N/A
| [pass-fcrepo-module-auth-rbacl](https://github.com/eclipse-pass/pass-fcrepo-module-auth-rbacl) | [birkland](https://github.com/birkland/fcrepo-module-auth-rbacl) | Role Based Authorization Delegate Module for the Fedora 4 Repository


## Dependencies

| Element | Current Version | Latest Version | Notes
| --- | --- | --- | --- |
| Go | 1.12 | [1.18](https://go.dev/dl/) | Programming language
| Java | 11 | [22](https://www.java.com/releases/) | Programming language
| Fedora | 4.7.5 | [6.1.1](https://github.com/fcrepo/fcrepo/releases) | Document store (database) for PASS
| Postgres | 13.3 | [14.2](https://www.postgresql.org/docs/release/) | Underlying storage of Fedora
| Node |  | [18.x](https://nodejs.org/en/about/releases/) | JavaScript runtime, unconfirmed on desired version
| Npm |  | [6.14.8](https://github.com/npm/npm/releases) | Package manager for node |
| Maven | 3.6.3 | [3.8.5](https://maven.apache.org/docs/history.html) | Java Package manager
| ElasticSearch| 7.13.3 | [8.1.3](https://github.com/elastic/elasticsearch/releases) | Search / indexing
| Shibboleth | 2 | [3.3.0](https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2065335693/ReleaseNotes) | Authentication
| Ember.js | 3.8 | [3.28.8](https://github.com/emberjs/ember.js/releases) | The user interface
| Ember CLI | 2.13 | [4.3.0](https://github.com/ember-cli/ember-cli/releases) | CLI for managing an ember application |

## References

* [Travis configs for pass-ui](https://travis-ci.org/github/OA-PASS/pass-ember/jobs/770188235/config)
* [Coveralls for pass-ui (pass-ember URL no longer valid)](https://coveralls.io/)

