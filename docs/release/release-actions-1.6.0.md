# Release Manager Actions Checklist Template

|  |  |
| --- | --- |
| Release version | 1.6.0 |
| Next dev version | 1.7.0-SNAPSHOT  |

## Release Process Overview
This is the full detailed release process, including the steps that are performed by the GitHub automation: [Release](../dev/release.md)

## Pre-release

- [x] Identify the version to be utilized for the release.
- [x] Ensure all code commits and PRs intended for the release have been merged.
- [x] Issue a code freeze statement on the Eclipse PASS slack #pass-dev channel to notify all developers that a release is imminent.


## Release Java Projects
[Release Steps with Automations](../dev/release-steps-with-automations.md)

[Release All Java Modules Workflow](https://github.com/eclipse-pass/main/actions/workflows/pass-java-release.yml)

Java Modules:
- [x] Release Main
- [x] Release Pass-Core
- [x] Release Pass Support


## Release Non-Java Projects

- [x] Release Pass UI - [Pass UI workflow](https://github.com/eclipse-pass/pass-ui/actions/workflows/release.yml)
- [x] Verify Pass UI packages [Pass UI Packages](https://github.com/eclipse-pass/pass-ui/pkgs/container/pass-ui)
- [x] Pass UI Release Page - Perform after the Pass UI release is complete - [Pass UI GitHub Release Page](https://github.com/eclipse-pass/pass-ui/releases)

 ---
 
- [x] Release Pass Acceptance Testing - [Pass Acceptance Testing workflow](https://github.com/eclipse-pass/pass-acceptance-testing/actions/workflows/release.yml)
- [x] Verify Pass Acceptance Testing Tag [Pass Acceptance Testing Tag](https://github.com/eclipse-pass/pass-acceptance-testing/tags)
- [x] Pass Acceptance Testing Release Page - Perform after the Pass Acceptance Testing release is complete - [Pass Acceptance Testing GitHub Release Page](https://github.com/eclipse-pass/pass-acceptance-testing/releases)

## Release Other Projects
Note: This must be released last because it relies on some Docker images that will be published during the release process.

- [x] Release Pass Docker - Select checkbox for acceptance tests - [Release workflow](https://github.com/eclipse-pass/pass-docker/actions/workflows/release.yml)
- [x] Verify Pass  Docker Tag [Pass Docker Tag](https://github.com/eclipse-pass/pass-docker/tags)
- [x] Pass Docker Release Page - Perform after the Pass Docker release is complete - [Pass Docker GitHub Release Page](https://github.com/eclipse-pass/pass-docker/releases)

## Post-release

- [x] Test the release by using the newly updated pass-docker to run the release locally.
- [x] Check that correct tickets are in the release milestone. [Github Ticket Update](../dev/release.md#update-release-notes)
- [x] Write release notes in the [Release Notes doc](../release-notes.md), submit a PR for the changes, and ensure the PR is merged. Release Notes should be written to be understandable by community members who are not technical.
- [x] Draft release message and have technical & community lead provide feedback. Ensure that a link to the release notes is included in the release message.
- [x] Post a message about the release to the PASS Google Group.  [Notes about the PASS Google Group](../dev/release.md#process)
- [x] Update template if any steps were missed or if any new tasks were added. Also make note of these new steps in the release-actions-X.X.X.md file.
- [x] Update [Pass Demo](https://demo.eclipse-pass.org) to new release - [Publish to SNS Topic action](https://github.com/eclipse-pass/main/actions/workflows/deployToAWS.yml) using `Environment: demo`
- [x] Send message to Eclipse PASS slack #pass-dev channel that the release is complete.