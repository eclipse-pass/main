# Release Manager Actions Checklist Template

## Release Process Overview
This is the full detailed release process, including the steps that are performed by the GitHub automation: [Release](../dev/release.md)

## Pre-release

- [ ] Identify the version to be utilized for the release.
- [ ] Ensure all code commits and PRs intended for the release have been merged.
- [ ] Issue a code freeze statement on the Eclipse PASS slack #general channel to notify all developers that a release is imminent.

## Release Java Projects
[Release Steps with Automations](../dev/release-steps-with-automations.md)

Release Workflow Example: [Triggering a GitHub workflow](../dev/release-steps-with-automations.md#triggering-a-gitHub-workflow)

- [ ] Release Main - [Main Release workflow](https://github.com/eclipse-pass/main/actions/workflows/release.yml)
- [ ] Main GitHub Release Page - Perform after the Main release is complete - [Main GitHub Release Page](https://github.com/eclipse-pass/main/releases)
- [ ] Release Pass-Core - [Pass-Core Release workflow](https://github.com/eclipse-pass/pass-core/actions/workflows/release.yml)
- [ ] Pass-Core GitHub Release Page - Perform after the Pass Core release is complete - [Pass Core GitHub Release Page](https://github.com/eclipse-pass/pass-core/releases)
- [ ] Release Pass Support - [Pass Support Release workflow](https://github.com/eclipse-pass/pass-support/actions/workflows/release.yml)
- [ ] Pass Support GitHub Release Page - Perform after the Pass Support release is complete - [Pass Support GitHub Release Page](https://github.com/eclipse-pass/pass-support/releases)

## Release Non-Java Projects

- [ ] Release Pass UI - [Pass UI workflow](https://github.com/eclipse-pass/pass-ui/actions/workflows/release.yml)
- [ ] Pass UI Release Page - Perform after the Pass UI release is complete - [Pass UI GitHub Release Page](https://github.com/eclipse-pass/pass-ui/releases)
- [ ] Release Pass Auth - [Pass Auth workflow](https://github.com/eclipse-pass/pass-auth/actions/workflows/release.yml)
- [ ] Pass Auth Release Page - Perform after the Pass Auth release is complete - [Pass Auth GitHub Release Page](https://github.com/eclipse-pass/pass-auth/releases)
- [ ] Release Pass Acceptance Testing - [Pass Acceptance Testing workflow](https://github.com/eclipse-pass/pass-acceptance-testing/actions/workflows/release.yml)
- [ ] Pass Acceptance Testing Release Page - Perform after the Pass Acceptance Testing release is complete - [Pass Acceptance Testing GitHub Release Page](https://github.com/eclipse-pass/pass-acceptance-testing/releases)

## Release Other Projects

- [ ] Release Pass Docker - [Release workflow](https://github.com/eclipse-pass/pass-docker/actions/workflows/release.yml)

## Post-release

- [ ] Test the release by using the newly updated pass-docker to run the release locally.
- [ ] Write release notes in the [Release Notes doc](../release-notes.md), submit a PR for the changes, and ensure the PR is merged. Release Notes should be written to be understandable by community members who are not technical.
- [ ] Draft release message and have technical & community lead provide feedback. Ensure that a link to the release notes is included in the release message.
- [ ] Post a message about the release to the PASS Google Group.  [Notes about the PASS Google Group](../dev/release.md#process)
- [ ] Update template if any steps were missed or if any new tasks were added. Also make note of these new steps in the release-actions-X.X.X.md file.