# Eclipse PASS Project Roadmap

This roadmap defines the primary initiatives of the Eclipse PASS Project, organized by anticipated release.

If you are interested in helping to define and/or contribute to this roadmap, please get in touch. We're always happy to welcome new project contributors!

# Planned Releases
## 0.1.0
This will be the initial release of the PASS codebase after transition to Eclipse.
* Naming changes - updating code to transition to the Eclipse PASS name
* Version alignment - ensuring all project components utilize a consistent versioning scheme
* Adjustments to release process - updates to allow release of Java components to Maven Central with a new groupId
* Introduction of style guide - ensuring code conforms to consistent guidelines
* Adjustments to testing methods - transitioning to the use of GitHub Actions for the execution of unit and integration testing
* Initial documentation - providing a starting point for development and deployment documenatation

## 0.2.0
This release will focus on building consistency within the project codebase and enabling automation to simplify and speed the development process.
* Harmonize Integration Test setup - updating the method for executing integration tests to ensure consistent and streamlined launch and execution
* Harmonize Docker image generation - ensure Docker images are generated in a consistent way across all project components
* Automating the maven release and docker image building process - introducing additional automation to ensure consistency and reduce effort in the release of Maven artifacts and the generation of Docker images
* Verify consistent Java version - ensure all Java components and docker images require Java 11, as preparation to upgrade to more current Java versions

## 1.0.0
This release will include the replacement of a major system component, which is expected to simplify system interaction and increase performance. This will also be the first major release of the Eclipse PASS project.
* Fedora 4 replacement - update the data management layer of the stack
* Go project replacement - transition existing Go modules to use Java in order to unify the project codebase
* Dependency updates - update project dependencies and introduce automated convergence checks

## 1.1.0
This release will focus on ensuring that those operating and maintaining the PASS application have the information needed to visualize system activity
* Logging improvement - ensure logging is configured, captured, and utilized consistently across the project
* Monitoring and observability - define, capture, and expose metrics required for understanding performance, system utilization, and tracking errors