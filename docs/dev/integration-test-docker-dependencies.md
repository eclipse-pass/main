## Current Integration Testing Docker Dependencies

| Repo | Docker image |
| ---- | :---- |
| [pass-authz](https://github.com/eclipse-pass/pass-authz) | <ul><li>oapass/activemq:20180618</li><li>oapass/indexer:0.0.15-3.1-SNAPSHOT</li><li>oapass/pass-authz-fcrepo:${project.version}</li><li>docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3</li></ul> |
| [pass-deposit-services](https://github.com/eclipse-pass/pass-deposit-services) | <ul><li>oapass/ftpserver:latest</li><li>oapass/postgres:latest</li><li>oapass/dspace:20200419@sha256:99df12f10846f2a2d62058cf4eef631393d7949a343b233a9e487d54fd82a483</li><li>oapass/fcrepo:4.7.5-3.5@sha256:bb44fff182ace1d0d57372f297cbab8cc04c662db2d10a061213178b7c0c9bba</li><li>docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3</li><li>oapass/indexer-wrapped:latest</li></ul> |
| [pass-doi-services](https://github.com/eclipse-pass/pass-doi-service) | <ul><li>doi-service-its (self-built in project)</li><li>oapass/fcrepo:4.7.5-3.2-2</li><li>docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3</li><li>oapass/indexer@sha256:e51092a9d433219d52207f1ec3f5ea7c652d51f516bcbe9434dae556b921546d</li></ul> | 
| [pass-fcrepo-jms](https://github.com/eclipse-pass/pass-fcrepo-jms) |  |
| [pass-fcrepo-jsonld](https://github.com/eclipse-pass/pass-fcrepo-jsonld) |  |
| [pass-fcrepo-module-auth-rbacl](https://github.com/eclipse-pass/pass-fcrepo-module-auth-rbacl) |  |
| [pass-grant-loader](https://github.com/eclipse-pass/pass-grant-loader) | <ul><li>oapass/fcrepo:4.7.5-3.1-SNAPSHOT</li><li>oapass/indexer:0.0.15-3.1-SNAPSHOT</li><li>docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3</li></ul> |
| [pass-indexer](https://github.com/eclipse-pass/pass-indexer) |  |
| [pass-indexer-checker](https://github.com/eclipse-pass/pass-indexer-checker) | <ul><li>oapass/fcrepo:4.7.5-3.5-1</li><li>oapass/indexer:0.0.18-3.4-1</li><li>docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3</li></ul> |
| [pass-java-client](https://github.com/eclipse-pass/pass-java-client) | <ul><li>oapass/fcrepo:4.7.5-3.4</li><li>oapass/indexer:0.0.18-3.4</li><li>docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3</li></ul> |
| [pass-journal-loader](https://github.com/eclipse-pass/pass-journal-loader) | <ul><li>oapass/fcrepo:4.7.5-3.2-5</li></ul> |
| [pass-messaging-support](https://github.com/eclipse-pass/pass-messaging-support) |  |
| [pass-nihms-loader](https://github.com/eclipse-pass/pass-nihms-loader) | <ul><li>oapass/fcrepo:4.7.5-3.2-5</li><li>docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3</li><li>oapass/indexer@sha256:e51092a9d433219d52207f1ec3f5ea7c652d51f516bcbe9434dae556b921546d</li></ul> |
| [pass-notification-services](https://github.com/eclipse-pass/pass-notification-services) | <ul><li>oapass/fcrepo:4.7.5-3.4</li><li>oapass/indexer:0.0.18-3.4</li><li>docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3</li><li>oapass/docker-mailserver:20181105</li><li>oapass/ldap:20200610-jhu</li></ul> |
| [pass-package-providers](https://github.com/eclipse-pass/pass-package-providers) | <ul><li>oapass/deposit-services-providers-its:${project.parent.version}</li><li>oapass/fcrepo@sha256:3e39b01edf56c149279cfc51b647df335c01f9ec38036f1724f337ae35d68fe8</li><li>docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3</li><li>oapass/indexer@sha256:e51092a9d433219d52207f1ec3f5ea7c652d51f516bcbe9434dae556b921546d</li></ul> |
