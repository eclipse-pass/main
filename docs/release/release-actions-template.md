# Release Manager Actions Checklist Template

|  |  |
| --- | --- |
| Release version |  |
| Next dev version |  |

## Release Process Overview
This is the full detailed release process, including the steps that are performed by the GitHub automation: [Release](../dev/release.md)

## Pre-release

- [x] Identify the version to be utilized for the release.
- [x] Ensure all code commits and PRs intended for the release have been merged.
- [x] Issue a code freeze statement on the Eclipse PASS slack #pass-dev channel to notify all developers that a release is imminent.

[Release Steps with Automations](../dev/release-steps-with-automations.md)

## Release Projects

[Release All Modules Workflow](https://github.com/eclipse-pass/main/actions/workflows/pass-complete-release.yml)

- [ ] Release Main
- [ ] Release Pass-Core
- [ ] Release Pass Support
- [ ] Release Pass UI
- [ ] Release Pass Acceptance Testing
- [ ] Release Pass Docker

## Post-release

- [ ] Test the release by using the newly updated pass-docker to run the release locally.
- [ ] Check that correct tickets are in the release milestone. [GitHub Ticket Update](../dev/release.md#update-release-notes)
- [ ] Write release notes in the [Release Notes doc](../release-notes.md), submit a PR for the changes, and ensure the PR is merged. Release Notes should be written to be understandable by community members who are not technical.
- [ ] Draft release message and have technical & community lead provide feedback. Ensure that a link to the release notes is included in the release message.
- [ ] Post a message about the release to the PASS Google Group.  [Notes about the PASS Google Group](../dev/release.md#process)
- [ ] Update template if any steps were missed or if any new tasks were added. Also make note of these new steps in the release-actions-X.X.X.md file.
- [ ] Update [Pass Demo](https://demo.eclipse-pass.org) to new release - [Publish to SNS Topic action](https://github.com/eclipse-pass/main/actions/workflows/deployToAWS.yml) using `Environment: demo`
- [ ] Send message to Eclipse PASS slack #pass-dev channel that the release is complete.