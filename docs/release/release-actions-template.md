# Release Manager Actions Checklist Template

## Release Process Overview
This is the full detailed release process, including the steps that are performed by the GitHub automation: [Release](https://github.com/eclipse-pass/main/blob/main/docs/dev/release.md)

## Pre-release

- [ ] Ensure all code commits and PRs intended for the release have been merged.
- [ ] Issue a code freeze statement on the Eclipse PASS slack #general channel to notify all developers that a release is imminent.

## Release Java Projects
[Release Steps with Automations](https://github.com/eclipse-pass/main/blob/main/docs/dev/release-steps-with-automations.md)

Release Workflow Example: [Triggering a GitHub workflow](https://github.com/eclipse-pass/main/blob/main/docs/dev/release-steps-with-automations.md#triggering-a-gitHub-workflow)

- [ ] Release Main - [Main Release workflow](https://github.com/eclipse-pass/main/actions/workflows/release.yml)
- [ ] Main GitHub Release Page - Perform after the Main release is complete - [Main GitHub Release Page](https://github.com/eclipse-pass/main/releases)
- [ ] Release Pass-Core - [Pass-Core Release workflow](https://github.com/eclipse-pass/pass-core/actions/workflows/release.yml)
- [ ] Pass Core GitHub Release Page - Perform after the Pass Core release is complete - [Pass Core GitHub Release Page](https://github.com/eclipse-pass/pass-core/releases)
- [ ] Release Pass Support - [Pass Support Release workflow](https://github.com/eclipse-pass/pass-support/actions/workflows/release.yml)
- [ ] Pass Support GitHub Release Page - Perform after the Pass Support release is complete - [Pass Support GitHub Release Page](https://github.com/eclipse-pass/pass-support/releases)

## Release Non-Java Projects

- [ ] Release Pass UI - [Pass UI workflow](https://github.com/eclipse-pass/pass-ui/actions/workflows/release.yml)
- [ ] Release Pass Auth - [Pass Auth workflow](https://github.com/eclipse-pass/pass-auth/actions/workflows/release.yml)
- [ ] Release Pass Acceptance Testing - [Pass Acceptance Testing workflow](https://github.com/eclipse-pass/pass-acceptance-testing/actions/workflows/release.yml)

## Release Other Projects

- [ ] Release Pass Docker - [Release workflow](https://github.com/eclipse-pass/pass-docker/actions/workflows/release.yml)

## Post-release

- [ ] Test the release by using the newly updated pass-docker to run the release locally.
- [ ] Draft release message and have technical & community lead provide feedback.
- [ ] Post a message about the release to the PASS Google Group.  [Notes about the PASS Google Group](https://github.com/eclipse-pass/main/blob/main/docs/dev/release.md#process)