## Release v0.1.0
This is the initial release of the Eclipse PASS codebase. The following changes were made to the code after completing the transition to Eclipse:

Naming changes - updating code to transition to the Eclipse PASS name
Version alignment - ensuring all project components utilize a consistent versioning scheme
Data model alignment - ensuring all project components utilize the same version of the data model
Adjustments to release process - updates to allow release of Java components to Maven Central with a new groupId
Introduction of code style guide - ensuring code conforms to consistent guidelines
Adjustments to testing methods - transitioning to the use of GitHub Actions for the execution of unit and integration testing
Initial documentation - providing a starting point for development and deployment documentation

## Release v0.2.0
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


Some major changes for v0.2.0 are

* Replacement of Fedora storage with Elide / postgres.
* Creation of a pass-core repository which contains REST services previously in separate projects/images
* Elimination of functionality written in Go in previous releases. These have
either been implemented in Java or eliminated
* Refactoring of authorization functionality in javascript closer to the UI

## Release v0.3.0

This release introduces a new file handling service for dealing with file uploads in PASS. Releases are now largely automated using GitHub workflows.

* Release automations using GitHub workflows. Snapshot versions are published automatically and releases can be triggered manually in the GitHub UI
* Add file API to pass-core for handling file related create, read, and delete operations
