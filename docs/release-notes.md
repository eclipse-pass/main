## Release v1.3.0
### Date: January 31, 2024

This release focused on updating the interactions with NIHMS. A service was added to handle email messages from NIHMS about submission status. We made GitHub actions for Java snapshot and release builds consistent and more robust. We switched the grant loader to a CSV format which will make it easier to import grant data from other systems. For the UI, we improved the accessibility of the UI and the interaction with external links in the workflow.

Tickets Completed: https://github.com/eclipse-pass/main/milestone/17?closed=1

Release Components:
* main - https://github.com/eclipse-pass/main/releases/tag/1.3.0
* pass-core - https://github.com/eclipse-pass/pass-core/releases/tag/1.3.0
* pass-docker - https://github.com/eclipse-pass/pass-docker/releases/tag/1.3.0
* pass-acceptance-testing - https://github.com/eclipse-pass/pass-acceptance-testing/releases/tag/1.3.0
* pass-support - https://github.com/eclipse-pass/pass-support/releases/tag/1.3.0
* pass-auth - https://github.com/eclipse-pass/pass-auth/releases/tag/1.3.0
* pass-ui - https://github.com/eclipse-pass/pass-ui/releases/tag/1.3.0

## Release v1.2.0
### Date: November 30, 2023

This release focused on increasing the security of PASS and making interactions with external services more robust, notably the interface with NIHMS. Parameterized queries were added to the grant loader to enhance security. We've made substantial upgrades to the NIHMS data transfer within our Deposit Services and enhancements to the NIHMS loader. Updates were made to the data model documentation and client-side pagination support has been added in the UI.

Tickets Completed: https://github.com/eclipse-pass/main/milestone/16?closed=1

Release Components:
* main - https://github.com/eclipse-pass/main/releases/tag/1.2.0
* pass-core - https://github.com/eclipse-pass/pass-core/releases/tag/1.2.0
* pass-docker - https://github.com/eclipse-pass/pass-docker/releases/tag/1.2.0
* pass-acceptance-testing - https://github.com/eclipse-pass/pass-acceptance-testing/releases/tag/1.2.0
* pass-support - https://github.com/eclipse-pass/pass-support/releases/tag/1.2.0
* pass-auth - https://github.com/eclipse-pass/pass-auth/releases/tag/1.2.0
* pass-ui - https://github.com/eclipse-pass/pass-ui/releases/tag/1.2.0

## Release v1.1.0
### Date: October 26, 2023

This release focused on getting PASS ready for deployment in production. We did a great deal of testing of the user interface, backend services, and interactions with repositories. We found and fixed a large number of bugs. We significantly improved the performance of grant loading. We made accessibility improvements to the user interface.  In addition, we added support for depositing to repositories without requiring a journal be entered by the user.

Tickets Completed: https://github.com/eclipse-pass/main/milestone/15?closed=1

Release Components:
* main - https://github.com/eclipse-pass/main/releases/tag/1.1.0
* pass-core - https://github.com/eclipse-pass/pass-core/releases/tag/1.1.0
* pass-docker - https://github.com/eclipse-pass/pass-docker/releases/tag/1.1.0
* pass-acceptance-testing - https://github.com/eclipse-pass/pass-acceptance-testing/releases/tag/1.1.0
* pass-support - https://github.com/eclipse-pass/pass-support/releases/tag/1.1.0
* pass-auth - https://github.com/eclipse-pass/pass-auth/releases/tag/1.1.0
* pass-ui - https://github.com/eclipse-pass/pass-ui/releases/tag/1.1.0

## Release v1.0.0
### Date: September 29, 2023

This release focused on setting up a PASS for production readiness. We resolved a large number of bugs in the user interface and the API / backend services. We added optimistic locking to Submission and Deposit entities to ensure more expected behavior when users edit a shared resource. We also did work on tooling for data migration and remediation.

Tickets Completed: https://github.com/eclipse-pass/main/milestone/12?closed=1

Release Components:
* main - https://github.com/eclipse-pass/main/releases/tag/1.0.0
* pass-core - https://github.com/eclipse-pass/pass-core/releases/tag/1.0.0
* pass-docker - https://github.com/eclipse-pass/pass-docker/releases/tag/1.0.0
* pass-acceptance-testing - https://github.com/eclipse-pass/pass-acceptance-testing/releases/tag/1.0.0
* pass-support - https://github.com/eclipse-pass/pass-support/releases/tag/1.0.0
* pass-auth - https://github.com/eclipse-pass/pass-auth/releases/tag/1.0.0
* pass-ui - https://github.com/eclipse-pass/pass-ui/releases/tag/1.0.0

## Release v0.9.0
### Date: August 30, 2023

This release focused on setting up a staging environment for the PASS application. We deployed PASS to the new environment, integrated single sign-on and the data loaders, and fixed a number of bugs that were discovered in the refactored codebase.

Tickets Completed: https://github.com/eclipse-pass/main/milestone/13?closed=1

Release Components:
* main - https://github.com/eclipse-pass/main/releases/tag/0.9.0
* pass-core - https://github.com/eclipse-pass/pass-core/releases/tag/0.9.0
* pass-docker - https://github.com/eclipse-pass/pass-docker/releases/tag/0.9.0
* pass-acceptance-testing - https://github.com/eclipse-pass/pass-acceptance-testing/releases/tag/0.9.0
* pass-support - https://github.com/eclipse-pass/pass-support/releases/tag/0.9.0
* pass-auth - https://github.com/eclipse-pass/pass-auth/releases/tag/0.9.0
* pass-ui - https://github.com/eclipse-pass/pass-ui/releases/tag/0.9.0

## Release v0.8.0
### Date: July 28, 2023

This release introduces updated Java implementations of pass-deposit-services. All of the major functionality of PASS has now been ported to the new framework. In addition more testing was added to the pass-core file service and support for the file service was added to pass-data-client.

Tickets Completed: https://github.com/eclipse-pass/main/milestone/11

Release Components:
* main - https://github.com/eclipse-pass/main/releases/tag/0.8.0
* pass-core - https://github.com/eclipse-pass/pass-core/releases/tag/0.8.0
* pass-docker - https://github.com/eclipse-pass/pass-docker/releases/tag/0.8.0
* pass-acceptance-testing - https://github.com/eclipse-pass/pass-acceptance-testing/releases/tag/0.8.0
* pass-support - https://github.com/eclipse-pass/pass-support/releases/tag/0.8.0
* pass-auth - https://github.com/eclipse-pass/pass-auth/releases/tag/0.8.0
* pass-ui - https://github.com/eclipse-pass/pass-ui/releases/tag/0.8.0

## Release v0.7.0
### Date: June 29, 2023

This release introduces updated java implementations of the pass-nihms-loader and pass-notification-services projects. This release also introduces support for sending submission and deposit JMS message from pass-core, adds access control to the file-service, removes pass-ui-public from pass-docker, and cleans up the SAML configuration in pass-auth.

Tickets Completed: https://github.com/eclipse-pass/main/issues?q=label%3A%22Release+0.7.0%22

Release Components:
* main - https://github.com/eclipse-pass/main/releases/tag/0.7.0
* pass-core - https://github.com/eclipse-pass/pass-core/releases/tag/0.7.0
* pass-docker - https://github.com/eclipse-pass/pass-docker/releases/tag/0.7.0
* pass-acceptance-testing - https://github.com/eclipse-pass/pass-acceptance-testing/releases/tag/0.7.0
* pass-support - https://github.com/eclipse-pass/pass-support/releases/tag/0.7.0
* pass-auth - https://github.com/eclipse-pass/pass-auth/releases/tag/0.7.0
* pass-ui - https://github.com/eclipse-pass/pass-ui/releases/tag/0.7.0

## Release v0.6.0
### Date: May 31, 2023

This release introduces java implementations of the pass-journal-loader, pass-grant-loader and submission status service. This release also introduces support for user token authentication, updates to use of Java 17 in several repositories, converts pass-auth to TypeScript, integrates the user interface with the API for the policy service, introduces a simplified branding strategy along with default branding fallbacks to enable organization specific look and feel, and provides an action for publishing to an AWS SNS (Simple Notification Service) topic to facilitate deploying to AWS infrastructure.

Tickets Completed: https://github.com/eclipse-pass/main/issues?q=label%3A%22Release+0.6.0%22

Release Components:
* main - https://github.com/eclipse-pass/main/releases/tag/0.6.0
* pass-core - https://github.com/eclipse-pass/pass-core/releases/tag/0.6.0
* pass-docker - https://github.com/eclipse-pass/pass-docker/releases/tag/0.6.0
* pass-acceptance-testing - https://github.com/eclipse-pass/pass-acceptance-testing/releases/tag/0.6.0
* pass-support - https://github.com/eclipse-pass/pass-support/releases/tag/0.6.0
* pass-auth - https://github.com/eclipse-pass/pass-auth/releases/tag/0.6.0
* pass-ui-public - https://github.com/eclipse-pass/pass-ui-public/releases/tag/0.6.0
* pass-ui - https://github.com/eclipse-pass/pass-ui/releases/tag/0.6.0

## Release v0.5.0
### Date: April 27, 2023
This release introduces the Metadata Schema Service and the Policy Service API. The Metadata Schema Service provides JSON schemas for repository metadata requirements.
The Policy Service API determines the policies applicable to a given Submission, as well as the repositories that a Submission must be deposited into.
Release Automation has been expanded to include [pass-acceptance-testing](https://github.com/eclipse-pass/pass-acceptance-testing) and [pass-docker](https://github.com/eclipse-pass/pass-docker).

Tickets Completed: https://github.com/eclipse-pass/main/issues?q=label%3A%22Release+0.5.0%22

Release Components:
* main - https://github.com/eclipse-pass/main/releases/tag/0.5.0
* pass-core - https://github.com/eclipse-pass/pass-core/releases/tag/0.5.0
* pass-docker - https://github.com/eclipse-pass/pass-docker/releases/tag/0.5.0
* pass-acceptance-testing - https://github.com/eclipse-pass/pass-acceptance-testing/releases/tag/0.5.0
* pass-support - https://github.com/eclipse-pass/pass-support/releases/tag/0.5.0
* pass-auth - https://github.com/eclipse-pass/pass-auth/releases/tag/0.5.0
* pass-ui-public - https://github.com/eclipse-pass/pass-ui-public/releases/tag/0.5.0
* pass-ui - https://github.com/eclipse-pass/pass-ui/releases/tag/0.5.0

## Release v0.4.0
### Date: March 30, 2023
This release introduces a new user service and access control. The release also upgraded ember to the latest LTS Ember 4.

* Updated Ember packages and 3rd party dependencies
* Fixed styling post Ember 4 upgrade
* Introduces User Service Integration
* Introduces Access Control
* Standardized the entrypoint of dockerfiles to point at an entrypoint.sh file

Tickets Completed: https://github.com/eclipse-pass/main/issues?q=label%3A%22Release+0.4.0%22

Release Components:
* main - https://github.com/eclipse-pass/main/releases/tag/0.4.0
* pass-core - https://github.com/eclipse-pass/pass-core/releases/tag/0.4.0
* pass-docker - https://github.com/eclipse-pass/pass-docker/releases/tag/0.4.0
* pass-acceptance-testing - https://github.com/eclipse-pass/pass-acceptance-testing/releases/tag/0.4.0
* pass-support - https://github.com/eclipse-pass/pass-support/releases/tag/0.4.0
* pass-auth - https://github.com/eclipse-pass/pass-auth/releases/tag/0.4.0
* pass-ui-public - https://github.com/eclipse-pass/pass-ui-public/releases/tag/0.4.0
* pass-ui - https://github.com/eclipse-pass/pass-ui/releases/tag/0.4.0

## Release v0.3.0
### Date: February 28, 2023
This release introduces a new file handling service for dealing with file uploads in PASS. Releases are now largely automated using GitHub workflows.

* Release automations using GitHub workflows. Snapshot versions are published automatically and releases can be triggered manually in the GitHub UI
* Add file API to pass-core for handling file related create, read, and delete operations
* Add service to pass-core to look for publicly available manuscripts for a given DOI

Tickets Completed: https://github.com/eclipse-pass/main/issues?q=label%3A%22Release+0.3.0%22

Release Components:
* main - https://github.com/eclipse-pass/main/releases/tag/0.3.0
* pass-core - https://github.com/eclipse-pass/pass-core/releases/tag/0.3.0
* pass-docker - https://github.com/eclipse-pass/pass-docker/releases/tag/0.3.0
* pass-acceptance-testing - https://github.com/eclipse-pass/pass-acceptance-testing/releases/tag/0.3.0
* pass-support - https://github.com/eclipse-pass/pass-support/releases/tag/0.3.0
* pass-auth - https://github.com/eclipse-pass/pass-auth/releases/tag/0.3.0
* pass-ui-public - https://github.com/eclipse-pass/pass-ui-public/releases/tag/0.3.0
* pass-ui - https://github.com/eclipse-pass/pass-ui/releases/tag/0.3.0

## Release v0.2.0
### Date: January 18, 2023
Release 0.2.0 provides a major upgrade to the backend architecture of the PASS application.
The Fedora Repository has been replaced with a completely new REST API built using Elide and backed by
Postgres. This change allows the PASS API to be tailored more directly to the purposes of the PASS
application, provides considerable performance enhancements, and reduces maintenance burden.
The structure of the projects making up the PASS application have also been streamlined to simplify
release and deployment procedures. These changes require updates to be made across the application,
such as replacing all uses of the Fedora API within PASS with calls to the new API. For 0.2.0,
this work is completed sufficiently to provide a demonstration of PASS application capabilities,
but certain parts of the application are currently mocked. Full functionality
will be restored in a future release.

Tickets Completed: https://github.com/eclipse-pass/main/issues?q=label%3A%22Release+0.2.0%22

Release Components:
* main - https://github.com/eclipse-pass/main/releases/tag/0.2.0
* pass-core - https://github.com/eclipse-pass/pass-core/releases/tag/0.2.0
* pass-docker - https://github.com/eclipse-pass/pass-docker/releases/tag/0.2.0
* pass-acceptance-testing - https://github.com/eclipse-pass/pass-acceptance-testing/releases/tag/0.2.0
* pass-support - https://github.com/eclipse-pass/pass-support/releases/tag/0.2.0
* pass-auth - https://github.com/eclipse-pass/pass-auth/releases/tag/v0.2.0
* pass-ui-public - https://github.com/eclipse-pass/pass-ui-public/releases/tag/v0.2.0
* pass-ui - https://github.com/eclipse-pass/pass-ui/releases/tag/0.2.0

Some major changes for v0.2.0 are:

* Replacement of Fedora storage with Elide / postgres.
* Creation of a pass-core repository which contains REST services previously in separate projects/images
* Elimination of functionality written in Go in previous releases. These have
either been implemented in Java or eliminated
* Refactoring of authorization functionality in javascript closer to the UI

## Release v0.1.0
### Date: August 3, 2022
This is the initial release of the Eclipse PASS codebase. The following changes were made to the code after completing the transition to Eclipse:

Naming changes - updating code to transition to the Eclipse PASS name
Version alignment - ensuring all project components utilize a consistent versioning scheme
Data model alignment - ensuring all project components utilize the same version of the data model
Adjustments to release process - updates to allow release of Java components to Maven Central with a new groupId
Introduction of code style guide - ensuring code conforms to consistent guidelines
Adjustments to testing methods - transitioning to the use of GitHub Actions for the execution of unit and integration testing
Initial documentation - providing a starting point for development and deployment documentation

Tickets Completed: https://github.com/eclipse-pass/main/issues?q=label%3A%22Release+0.1.0%22

Release Components:
* main - https://github.com/eclipse-pass/main/releases/tag/0.1.0
* pass-ui-public - https://github.com/eclipse-pass/pass-ui-public/releases/tag/v0.1.0
* pass-ui - https://github.com/eclipse-pass/pass-ui/releases/tag/v0.1.0
* pass-ember-adapter - https://github.com/eclipse-pass/pass-ember-adapter/releases/tag/v0.1.0
* pass-java-client - https://github.com/eclipse-pass/pass-java-client/releases/tag/0.1.0
* pass-authz - https://github.com/eclipse-pass/pass-authz/releases/tag/0.1.0
* pass-deposit-services - https://github.com/eclipse-pass/pass-deposit-services/releases/tag/0.1.0
* pass-messaging-support - https://github.com/eclipse-pass/pass-messaging-support/releases/tag/0.1.0
* pass-notification-services - https://github.com/eclipse-pass/pass-notification-services/releases/tag/0.1.0
* pass-package-providers - https://github.com/eclipse-pass/pass-package-providers/releases/tag/0.1.0
* pass-doi-service - https://github.com/eclipse-pass/pass-doi-service/releases/tag/0.1.0
* pass-download-service - https://github.com/eclipse-pass/pass-download-service/releases/tag/0.1.0
* pass-policy-service - https://github.com/eclipse-pass/pass-policy-service/releases/tag/0.1.0
* pass-indexer-checker - https://github.com/eclipse-pass/pass-indexer-checker/releases/tag/0.1.0
* pass-indexer - https://github.com/eclipse-pass/pass-indexer/releases/tag/0.1.0
* pass-journal-loader - https://github.com/eclipse-pass/pass-journal-loader/releases/tag/0.1.0
* pass-nihms-loader - https://github.com/eclipse-pass/pass-nihms-loader/releases/tag/0.1.0
* pass-grant-loader - https://github.com/eclipse-pass/pass-grant-loader/releases/tag/0.1.0
* pass-fcrepo-jsonld - https://github.com/eclipse-pass/pass-fcrepo-jsonld/releases/tag/0.1.1
* pass-fcrepo-jms - https://github.com/eclipse-pass/pass-fcrepo-jms/releases/tag/0.1.0
* pass-docker - https://github.com/eclipse-pass/pass-docker/releases/tag/0.1.0

These repositories were involved in the release, but do not have a `0.1.0` release:
* pass-fcrepo-module-auth-rbacl - https://github.com/eclipse-pass/pass-fcrepo-module-auth-rbacl
* modeshape - https://github.com/eclipse-pass/modeshape
