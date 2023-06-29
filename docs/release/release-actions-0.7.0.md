# Release Manager Actions Checklist Template

## Release Process Overview
This is the full detailed release process, including the steps that are performed by the GitHub automation: [Release](../dev/release.md)

## Pre-release

- [X] Identify the version to be utilized for the release.
- [X] Ensure all code commits and PRs intended for the release have been merged.
- [X] Issue a code freeze statement on the Eclipse PASS slack #pass-dev channel to notify all developers that a release is imminent.

## Release Java Projects
[Release Steps with Automations](../dev/release-steps-with-automations.md)

Release Workflow Example: [Triggering a GitHub workflow](../dev/release-steps-with-automations.md#triggering-a-gitHub-workflow)

- [X] Release Main - [Main Release workflow](https://github.com/eclipse-pass/main/actions/workflows/release.yml)
- [X] Verify Main Artifacts on Maven Central - [Main Artifacts on Maven Central](https://central.sonatype.com/artifact/org.eclipse.pass/eclipse-pass-parent)
- [X] Main GitHub Release Page - Perform after the Main release is complete - [Main GitHub Release Page](https://github.com/eclipse-pass/main/releases)

- [X] Release Pass-Core - [Pass-Core Release workflow](https://github.com/eclipse-pass/pass-core/actions/workflows/release.yml)
- [X] Verify Pass-Core Artifacts on Maven Central - [Pass-Core Artifacts on Maven Central](https://central.sonatype.com/artifact/org.eclipse.pass/pass-core)
- [X] Pass-Core GitHub Release Page - Perform after the Pass Core release is complete - [Pass Core GitHub Release Page](https://github.com/eclipse-pass/pass-core/releases)

- [X] Release Pass Support - [Pass Support Release workflow](https://github.com/eclipse-pass/pass-support/actions/workflows/release.yml)
- [X] Verify Pass Support Artifacts on Maven Central - [Pass Support Artifacts on Maven Central](https://central.sonatype.com/artifact/org.eclipse.pass/pass-support)
- [X] Pass Support GitHub Release Page - Perform after the Pass Support release is complete - [Pass Support GitHub Release Page](https://github.com/eclipse-pass/pass-support/releases)

## Release Non-Java Projects

- [X] Release Pass UI - [Pass UI workflow](https://github.com/eclipse-pass/pass-ui/actions/workflows/release.yml)
- [X] Verify Pass UI packages [Pass UI Packages](https://github.com/eclipse-pass/pass-ui/pkgs/container/pass-ui)
- [X] Pass UI Release Page - Perform after the Pass UI release is complete - [Pass UI GitHub Release Page](https://github.com/eclipse-pass/pass-ui/releases)

- [X] Release Pass Auth - [Pass Auth workflow](https://github.com/eclipse-pass/pass-auth/actions/workflows/release.yml)
- [X] Verify Pass Auth packages [Pass Auth Packages](https://github.com/eclipse-pass/pass-auth/pkgs/container/pass-auth)
- [X] Pass Auth Release Page - Perform after the Pass Auth release is complete - [Pass Auth GitHub Release Page](https://github.com/eclipse-pass/pass-auth/releases)

- [X] Release Pass Acceptance Testing - [Pass Acceptance Testing workflow](https://github.com/eclipse-pass/pass-acceptance-testing/actions/workflows/release.yml)
- [X] Verify Pass Acceptance Testing Tag [Pass Acceptance Testing Tag](https://github.com/eclipse-pass/pass-acceptance-testing/tags)
- [X] Pass Acceptance Testing Release Page - Perform after the Pass Acceptance Testing release is complete - [Pass Acceptance Testing GitHub Release Page](https://github.com/eclipse-pass/pass-acceptance-testing/releases)

## Release Other Projects
Note: This must be released last because it relies on some Docker images that will be published during the release process.

- [X] Release Pass Docker - Select checkbox for acceptance tests - [Release workflow](https://github.com/eclipse-pass/pass-docker/actions/workflows/release.yml)
- [X] Pass Docker Release Page - Perform after the Pass Docker release is complete - [Pass Docker GitHub Release Page](https://github.com/eclipse-pass/pass-docker/releases)

## Post-release

- [X] Test the release by using the newly updated pass-docker to run the release locally.
- [X] Create label for release. Add labels to Issues in Eclipse-Pass/Main (Kanban Board) that are associated with the release. [Eclipse Pass KanBan Board](https://github.com/orgs/eclipse-pass/projects/4/views/2)
- [X] Write release notes in the [Release Notes doc](../release-notes.md), submit a PR for the changes, and ensure the PR is merged. Release Notes should be written to be understandable by community members who are not technical.
- [X] Draft release message and have technical & community lead provide feedback. Ensure that a link to the release notes is included in the release message.
- [X] Post a message about the release to the PASS Google Group.  [Notes about the PASS Google Group](../dev/release.md#process)
- [X] Update template if any steps were missed or if any new tasks were added. Also make note of these new steps in the release-actions-X.X.X.md file.
- [X] Update [Pass Demo](https://demo.eclipse-pass.org) to new release - [Publish to SNS Topic action](https://github.com/eclipse-pass/main/actions/workflows/deployToAWS.yml) using `Environment: demo`
- [X] Send message to Eclipse PASS slack #pass-dev channel that the release is complete.