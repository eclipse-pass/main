# Eclipse PASS Project Roadmap

This roadmap defines the primary initiatives of the Eclipse PASS Project, organized by anticipated release.

If you are interested in helping to define and/or contribute to this roadmap, please get in touch. We're always happy to welcome new project contributors!

# Completed Releases
## [0.1.0](https://github.com/eclipse-pass/main/releases/tag/0.1.0)
## [0.2.0](https://github.com/eclipse-pass/main/releases/tag/0.2.0)

# Planned Releases

## 0.3.0
This release will focus on making the REST API feature complete and removing the mocking of services in the user interface.
* Automating the release process
* Access control for REST API
* Dependency updates - update project dependencies and introduce automated convergence checks
* New file service (with support for both local and S3 storage)
* Replacement of all Golang web services.
* Remove mocking of the REST API from the user interface

## 1.0.0
This release aims to be a fully functional system.
* Data loaders ported to new framework
* Notification service ported to new framework
* Deposit service ported to new framework
* Archive old repositories

## 1.1.0
This release will focus on setup and improvement of application testing environments as well as moving towards greater codebase language consistency.
* Harmonize Integration Test setup - updating the method for executing integration tests to ensure consistent and streamlined launch and execution
* Addition of system tests - adding a mechanism and tests to support full-system verification
* Go project replacement - transition existing Go modules to use Java in order to unify the project codebase

## 1.2.0
This release will focus on ensuring that those operating and maintaining the PASS application have the information needed to visualize system activity
* Logging improvement - ensure logging is configured, captured, and utilized consistently across the project
* Monitoring and observability - define, capture, and expose metrics required for understanding performance, system utilization, and tracking errors
