# PASS Pipeline

This will document the progression from source code commits to
a production running application for the many [PASS components](/docs/dev#components).

| Project | Build | UTs |ITs | Deploy | Notes |
| --- | --- | --- | --- | --- | --- |
| [pass-authz](https://github.com/eclipse-pass/pass-authz) | ✅ | ✅ | ✅ | ❓ |  |
| [pass-data-model](https://github.com/eclipse-pass/pass-data-model) | ❌ | ❌ | ❌ | ❓ |  |
| [pass-ui](https://github.com/eclipse-pass/pass-ui) | ✅ | ✅ | ❌ | ❓ |  |
| [pass-ui-public](https://github.com/eclipse-pass/pass-ui-public) | ❌ | ❌ | ❌ | ❓ |  |
| [pass-ember-adapter](https://github.com/eclipse-pass/pass-ember-adapter) | ✅ | ✅ | ❎ | ❓|  |
| [pass-indexer](https://github.com/eclipse-pass/pass-indexer) | ✅ | ✅ | ✅ | ❓ |
| [pass-policy-service](https://github.com/eclipse-pass/pass-policy-service) | ✅ | ✅ | ✅ | ❓ |
| [pass-metadata-schemas](https://github.com/eclipse-pass/pass-metadata-schemas) | ✅ | ✅ | ❌ | ❓ |
| [pass-download-service](https://github.com/eclipse-pass/pass-download-service) | ✅ | ❌ | ❎ | ❓ |
| [pass-notification-services](https://github.com/eclipse-pass/pass-notification-services) | ✅ | ✅ | ✅ | ❓ |
| [pass-doi-service](https://github.com/eclipse-pass/pass-doi-service) | ✅ | ✅ | ❎ | ❓ |
| [pass-deposit-services](https://github.com/eclipse-pass/pass-deposit-services) | ✅ | ✅ | ✅ | ❓ |
| [pass-indexer-checker](https://github.com/eclipse-pass/pass-indexer-checker) | ✅ | ✅ | ✅ | ❓ |
| [pass-java-client](https://github.com/eclipse-pass/pass-java-client) | ✅ | ✅ | ✅ | ❓ |
| [pass-messaging-support](https://github.com/eclipse-pass/pass-messaging-support) | ✅ | ✅ | ✅ | ❓ |
| [pass-package-providers](https://github.com/eclipse-pass/pass-package-providers) | ✅ | ✅ | ✅ | ❓ |

There are a few additional project that help support Eclipse PASS but are not
part of the core application.

| Project | Build | UTs |ITs | Deploy | Notes |
| --- | --- | --- | --- | --- | --- |
| [pass-docker](https://github.com/eclipse-pass/pass-docker) | ❌ | ❌ | ❌ | ❓ |
| [playground](https://github.com/eclipse-pass/playground) | ❌ | ❌ | ❌ | ❓ |
| [pass-dupe-checker](https://github.com/eclipse-pass/pass-dupe-checker) | ✅ | ✅ | ❌ | ❓ |
| [pass-docker-mailserver](https://github.com/eclipse-pass/pass-docker-mailserver) | ❎ | ❌ | ❌ | ❓ |

The following application help load data into PASS

| Project | Build | UTs |ITs | Deploy | Notes |
| --- | --- | --- | --- | --- | --- |
| [pass-nihms-loader](https://github.com/eclipse-pass/pass-nihms-loader) | ✅ | ✅ | ✅ | ❓ |
| [pass-grant-loader](https://github.com/eclipse-pass/pass-grant-loader) | ✅ | ✅ | ✅ | ❓ |
| [pass-journal-loader](https://github.com/eclipse-pass/pass-journal-loader) | ✅ | ✅ | ✅ | ❓ |

The following repositories have been forked from others

| Project | Forked From | Notes |
| ---
| [modeshape](https://github.com/eclipse-pass/modeshape) | [ModeShape](https://github.com/ModeShape/modeshape) |
| [pass-fcrepo-module-auth-rbacl](https://github.com/eclipse-pass/pass-fcrepo-module-auth-rbacl) | [birkland](https://github.com/birkland/fcrepo-module-auth-rbacl) |

## Unit Testing

| Project | Command | Dependencies |
| --- | --- | --- |
| pass-ember-adapter | export FEDORA_ADAPTER_INTEGRATION_TEST=0<br>yarn install<br>ember test | Ember.js Ember
| pass-ui | npm config set spin false<br>yarn install<br>ember test --test-port=4200 | NPM, Yarn, Ember.js
| pass-deposit-services | mvn test | Maven, Java
| pass-authz | mvn -pl -pass-authz-integration test | Maven, Java 8
| pass-java-client |  mvn test -DskipITs=true | Java, mvn test works if mvn package run first.
| pass-indexer | mvn test -DskipITs=true | Java
| pass-policy-service | go test ./... | Go
| pass-metadata-schemas | go test ./... | Go
| pass-download-service | go test ./... | Go
| pass-notification-services | mvn test | Java 8
| pass-doi-service | mvn test | Java
| pass-indexer-checker | mvn test | Java
| pass-dupe-checker | go test | Go
| pass-package-providers | mvn test | Java, Mvn 3.6.3 (depending on platform, later release might work)
| pass-messaging-support | mvn test | Java
| pass-nihms-loader | mvn test | Java
| pass-grant-loader | mvn test | Java
| pass-journal-loader | mvn test | Java
| pass-fcrepo-module-auth-rbacl | mvn test | Java 8, Mvn 3.6.3 (depending on platform, later release might work)

## Integration Testing

| Project | Command | Dependencies |
| --- | --- | --- |
| pass-ember-adapter | docker-compose up -d<br>yarn install<br>ember test | Ember.js Ember Docker
| pass-deposit-services | mvn verify | Maven, Java, Docker
| pass-authz | mvn verify | Maven, Java 8, Docker
| pass-java-client | mvn verify | Java, Docker, mvn verify works if mvn package run first.
| pass-indexer | docker-compose up -d<br>mvn verify | Java, Docker
| pass-policy-service | docker-compose up -d<br>go test -tags=integration ./... | Go
| pass-download-service | docker-compose up -d<br>go test -tags=integration ./... | Go
| pass-notification-services | mvn verify | Java 8, Docker
| pass-doi-service | mvn verify | Java, Docker
| pass-indexer-checker | mvn verify | Java, Docker
| pass-package-providers | mvn verify | Java, Docker, Mvn 3.6.3 (depending on platform, later release might work)
| pass-messaging-support | mvn verify | Java, Docker
| pass-nihms-loader | mvn verify | Java, Docker
| pass-grant-loader | mvn verify | Java, Docker
| pass-journal-loader | mvn verify | Java, Docker
| pass-fcrepo-module-auth-rbacl | mvn test | Java 8, Mvn 3.6.3 (depending on platform, later release might work)

## Building

| Project | Command | Dependencies |
| --- | --- | --- |
| pass-ember-adapter | yarn install<br>ember build | Ember.js Ember
| pass-ui | yarn install<br>ember build | Ember.js Ember
| pass-deposit-services | mvn install | Maven, Java, Docker
| pass-authz | mvn install | Maven, Java 8, Docker
| pass-java-client | mvn install | Java, Docker
| pass-indexer | docker-compose up -d<br>mvn install | Java, Docker
| pass-policy-service | go generate ./...<br>go build ./cmd/pass-policy-service | Go
| pass-docker-mailserver | docker build -t oapass/docker-mailserver:DATE . | Docker
| pass-metadata-schemas | go build ./cmd/pass-schema-service | Go
| pass-download-service | go build | Go
| pass-notification-services | mvn install | Java, Docker
| pass-doi-service | mvn install | Java, Docker
| pass-indexer-checker | mvn install | Java, Docker
| pass-dupe-checker | go build | Go
| pass-package-providers | mvn install | Java, Docker
| pass-messaging-support | mvn install | Java, Docker
| pass-nihms-loader | mvn install | Java, Docker
| pass-grant-loader | mvn install | Java, Docker
| pass-journal-loader | mvn install | Java, Docker

## Dependencies

| Element | Current Version | Latest Version | Notes
| --- | --- | --- | --- |
| Go | 1.12 | [1.18](https://go.dev/dl/) | Programming language
| Java | 11 | [22](https://www.java.com/releases/) | Programming language
| Fedora | 4.7.5 | [6.1.1](https://github.com/fcrepo/fcrepo/releases) | Document store (database) for PASS
| Postgres | 13.3 | [14.2](https://www.postgresql.org/docs/release/) | Underlying storage of Fedora
| Node | 14.x | [18.x](https://nodejs.org/en/about/releases/) | JavaScript runtime, unconfirmed on desired version
| Npm | 6.14.x | [6.14.8](https://github.com/npm/npm/releases) | Package manager for node |
| Maven | 3.6.3 | [3.8.5](https://maven.apache.org/docs/history.html) | Java Package manager
| ElasticSearch| 7.13.3 | [8.1.3](https://github.com/elastic/elasticsearch/releases) | Search / indexing
| Shibboleth | 2 | [3.3.0](https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2065335693/ReleaseNotes) | Authentication
| Ember.js | 3.8 | [3.28.8](https://github.com/emberjs/ember.js/releases) | The user interface
| Ember CLI | 2.13 | [4.3.0](https://github.com/ember-cli/ember-cli/releases) | CLI for managing an ember application |
| Docker Compose | 1.29.2 | [2.5.0](https://github.com/docker/compose/releases) | CLI for managing docker containers |

## References

* [Deploying pass-docker via EC2](/docs/infra/ec2.md)
* [Our attempt to use Komposer to migrate Docker Compose to k8s manifest](/docs/infra/docker-composer-to-k8s-manifest.md)
* [Travis configs for pass-ui](https://travis-ci.org/github/OA-PASS/pass-ember/jobs/770188235/config)
* [Coveralls for pass-ui (pass-ember URL no longer valid)](https://coveralls.io/)
