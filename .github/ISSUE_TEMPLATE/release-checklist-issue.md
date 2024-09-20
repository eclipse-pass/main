---
name: Release Checklist Issue
about: PASS Release Checklist includes all the necessary steps required to successfully release the next version of PASS.
title: 'Release MAJOR.MINOR.PATCH'
labels: 'Release'
assignees: ''

---

# Release Manager Actions Checklist

|                  |                            |
|------------------|----------------------------|
| Release version  | MAJOR.MINOR.PATCH          |
| Next dev version | MAJOR.MINOR.PATCH-SNAPSHOT |

## Release Process Overview
This is the full detailed release process, including the steps that are performed by the GitHub automation: [Release](https://github.com/eclipse-pass/main/blob/main/docs/dev/release.md)

## Pre-release

- [] Identify the version to be utilized for the release.
- [] Ensure all code commits and PRs intended for the release have been merged.
- [] Issue a code freeze statement on the Eclipse PASS slack #pass-dev channel to notify all developers that a release is imminent.

[Release Steps with Automations](https://github.com/eclipse-pass/main/blob/main/docs/dev/release-steps-with-automations.md)

## Release Projects

[Release All Modules Workflow](https://github.com/eclipse-pass/main/actions/workflows/pass-complete-release.yml)

- [] Release Main
- [] Release Pass-Core
- [] Release Pass Support
- [] Release Pass UI
- [] Release Pass Acceptance Testing
- [] Release Pass Docker

## Post-release

- [] Test the release by using the [acceptance test workflow](https://github.com/eclipse-pass/pass-acceptance-testing/actions/workflows/test.yml). Enter the release number into the Ref field.
- [] Check that correct tickets are in the release milestone. [GitHub Ticket Update](https://github.com/eclipse-pass/main/blob/main/docs/dev/release.md#update-release-notes)
- [] Write release notes in the [Release Notes doc](https://github.com/eclipse-pass/main/blob/main/docs/release-notes.md), submit a PR for the changes, and ensure the PR is merged. Release Notes should be written to be understandable by community members who are not technical.
- [] Draft release message and have technical & community lead provide feedback. Ensure that a link to the release notes is included in the release message.
- [] Post a message about the release to the PASS Google Group.  [Notes about the PASS Google Group](https://github.com/eclipse-pass/main/blob/main/docs/dev/release.md#process)
- [] Update [Pass Demo](https://demo.eclipse-pass.org) to new release - [Publish to SNS Topic action](https://github.com/eclipse-pass/main/actions/workflows/deployToAWS.yml) using `Environment: demo`
- [] Send message to Eclipse PASS slack #pass-dev channel that the release is complete.