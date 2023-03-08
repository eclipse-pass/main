# Eclipse PASS Project Roadmap

This roadmap defines the primary initiatives of the Eclipse PASS Project, organized by anticipated release.

If you are interested in helping to define and/or contribute to this roadmap, please get in touch. We're always happy to welcome new project contributors!

# [Completed Releases](release-notes.md)

# Planned Releases

## 0.4.0
This release will focus on making the REST API feature complete and connecting the UI to the completed API
* Access control for REST API
* Replacement of all Golang web services.
* Remove mocking of the REST API from the user interface

## 0.5.0
This release will focus on tools to load data
* Data loaders ported to utilize the new REST API and backend framework

## 0.6.0
This release will focus on the deposit and notification services
* Notification service ported to new framework
* Deposit service ported to new framework

## 1.0.0
This release aims to be a fully functional system.
* Address technical debt
* Dependency updates - update project dependencies and introduce automated convergence checks
* Move to Java 17
* Archive old repositories

## 1.1.0
This release will focus on setup and improvement of application testing environments as well as moving towards greater codebase language consistency.
* Harmonize Integration Test setup - updating the method for executing integration tests to ensure consistent and streamlined launch and execution
* Addition of system tests - adding a mechanism and tests to support full-system verification

## 1.2.0
This release will focus on ensuring that those operating and maintaining the PASS application have the information needed to visualize system activity
* Logging improvement - ensure logging is configured, captured, and utilized consistently across the project
* Monitoring and observability - define, capture, and expose metrics required for understanding performance, system utilization, and tracking errors
