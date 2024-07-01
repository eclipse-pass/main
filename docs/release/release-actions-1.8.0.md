# Release Manager Actions Checklist Template

|  |  |
| --- |--|
| Release version | 1.8.0 |
| Next dev version | 1.9.0-SNAPSHOT |

## Release Process Overview
This is the full detailed release process, including the steps that are performed by the GitHub automation: [Release](../dev/release.md)

## Pre-release

- [x] Identify the version to be utilized for the release.
- [x] Ensure all code commits and PRs intended for the release have been merged.
- [x] Issue a code freeze statement on the Eclipse PASS slack #pass-dev channel to notify all developers that a release is imminent.

[Release Steps with Automations](../dev/release-steps-with-automations.md)

## Release Projects

[Release All Modules Workflow](https://github.com/eclipse-pass/main/actions/workflows/pass-complete-release.yml)

- [x] Release Main
- [x] Release Pass-Core
- [x] Release Pass Support
- [x] Release Pass UI
- [x] Release Pass Acceptance Testing
- [x] Release Pass Docker

## Post-release

- [x] Test the release by using the [acceptance test workflow](https://github.com/eclipse-pass/pass-acceptance-testing/actions/workflows/test.yml). Enter the release number into the Ref field.
- [x] Check that correct tickets are in the release milestone. [GitHub Ticket Update](../dev/release.md#update-release-notes)
- [x] Write release notes in the [Release Notes doc](../release-notes.md), submit a PR for the changes, and ensure the PR is merged. Release Notes should be written to be understandable by community members who are not technical.
- [x] Draft release message and have technical & community lead provide feedback. Ensure that a link to the release notes is included in the release message.
- [x] Post a message about the release to the PASS Google Group.  [Notes about the PASS Google Group](../dev/release.md#process)
- [x] Update template if any steps were missed or if any new tasks were added. Also make note of these new steps in the release-actions-X.X.X.md file.
- [x] Update [Pass Demo](https://demo.eclipse-pass.org) to new release - [Publish to SNS Topic action](https://github.com/eclipse-pass/main/actions/workflows/deployToAWS.yml) using `Environment: demo`
- [x] Send message to Eclipse PASS slack #pass-dev channel that the release is complete.
