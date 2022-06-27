# Developer Documentation

Developer focused documentation should be written in this `docs/dev/` directory. Separate documentation pages can be added in this directory and referenced here. If a given component has many documentation pages, please add a directory for it within the [docs/dev/](/docs/dev) directory.

## Components

The PASS application is split between many components.  Below is a summary

| Component | Summary |
| --- | --- |
| [pass-authz](https://github.com/eclipse-pass/pass-authz) | Various authz related components including a user service for dermining the logged in user (included in fcrepo image by pass-docker) and a service for automatically updating the permission on fcrepo objects (authz image in pass-docker) |
| [pass-data-model](https://github.com/eclipse-pass/pass-data-model) | `JSON-LD` [contexts](https://oa-pass.github.io/pass-data-model/src/main/resources/context.jsonld) | URLs need updating to eclipse-pass |
| [pass-ui](https://github.com/eclipse-pass/pass-ui) | The user interface written in Ember |
| [pass-ui-public](https://github.com/eclipse-pass/pass-ui-public) | Holds most of the static assets used by the [pass-ui](https://github.com/eclipse-pass/pass-ui) |
| [pass-ember-adapter](https://github.com/eclipse-pass/pass-ember-adapter) | Adapter for interacting with the Fedora repository |
| [pass-indexer](https://github.com/eclipse-pass/pass-indexer) | The pass-indexer keeps an Elasticsearch index up to date with resources in a Fedora repository.
| [pass-policy-service](https://github.com/eclipse-pass/pass-policy-service) | HTTP API for determining the policies applicable to a given Submission
| [pass-metadata-schemas](https://github.com/eclipse-pass/pass-metadata-schemas) | JSON schemas and example data intended to describe PASS submission metadata
| [pass-download-service](https://github.com/eclipse-pass/pass-download-service) | PASS download service
| [pass-notification-services](https://github.com/eclipse-pass/pass-notification-services) | Notification Services (NS) reacts to SubmissionEvent messages emitted by the Fedora repository by composing and dispatching notifications in the form of emails to the participants related to the event.
| [pass-doi-service](https://github.com/eclipse-pass/pass-doi-service) | Service for accepting a DOI and returning a Journal ID and Crossref metadata for the DOI
| [pass-deposit-services](https://github.com/eclipse-pass/pass-deposit-services) | Deposit Services are responsible for the transfer of custodial content and metadata from end users to repositories. Includes Dockerfile for service.
| [pass-indexer-checker](https://github.com/eclipse-pass/pass-indexer-checker) | A simple check of the indexer before kicking off a push for a loader
| [pass-java-client](https://github.com/eclipse-pass/pass-java-client) | Java library for interacting with PASS data
| [pass-messaging-support](https://github.com/eclipse-pass/pass-messaging-support) | Support library for interacting with fcrepo
| [pass-package-providers](https://github.com/eclipse-pass/pass-package-providers) | Contains support for pass-deposit-services to package deposits for various repositories. Also has Dockerfiles which add provider support by extending pass-deposit-services image. Requires max mvn version 3.6.3 (though seems to depend on the platform) which permits insecure (http) repositories (e.g. http://maven.dataconservancy.org/public/releases/org/dataconservancy/pass/mets-api/1.3.0/mets-api-1.3.0.jar)

There are a few additional project that help support Eclipse PASS but are not
part of the core application.

| Component | Summary |
| --- | --- |
| [pass-docker](https://github.com/eclipse-pass/pass-docker) | The canonical environment for demonstrating integration of the [PASS UI application](https://github.com/eclipse-pass/pass-ui)
| [playground](https://github.com/eclipse-pass/playground) | An collection of small hello-world like applications written in the technologies being used with eclipse-pass so that we can isolate, build, deploy and troubleshoot ops procedures separate from issues with the underlying projects. |
| [pass-dupe-checker](https://github.com/eclipse-pass/pass-dupe-checker) | Traverses a Fedora repository containing PASS resources, and for each resource, determines if a duplicate exists
| [pass-docker-mailserver](https://github.com/eclipse-pass/pass-docker-mailserver) | This fork of docker-mailserver is purpose-built to support integration testing of PASS components

The following application help load data into PASS

| Component | Summary |
| --- | --- |
| [pass-nihms-loader](https://github.com/eclipse-pass/pass-nihms-loader) | The NIHMS Submission ETL contains the components required to download, transform and load Submission information from NIHMS to PASS.
| [pass-grant-loader](https://github.com/eclipse-pass/pass-grant-loader) | This project is comprised of code for retrieving grant data from some kind of data source, and using that data to update the PASS backend.
| [pass-journal-loader](https://github.com/eclipse-pass/pass-journal-loader) |Parses the PMC type A journal .csv file, and/or the medline database .txt file, and syncs with the repository

The following repositories have been forked from others

| Component | Forked From | Notes |
| --- | --- | --- |
| [modeshape](https://github.com/eclipse-pass/modeshape) | [ModeShape](https://github.com/ModeShape/modeshape) | N/A
| [pass-fcrepo-module-auth-rbacl](https://github.com/eclipse-pass/pass-fcrepo-module-auth-rbacl) | [birkland](https://github.com/birkland/fcrepo-module-auth-rbacl) | Role Based Authorization Delegate Module for the Fedora 4 Repository


## Development Guidelines

### Committers and Contributors

Only Committers on the PASS Eclipse project are able to make changes to the code repositories, however contributions from non-committers are welcome and encouraged. These contributions should be made in the form of a Pull Request (PR) on the appropriate GitHub repository.

### Contribution Guidelines

- All code changes should be submitted in the form of a Pull Request (PR).
- PRs should be associated with an existing GitHub issue and the issue should be linked in the PR description.
- PRs should be reviewed by at least one committer that is not the PR author before merging.
- The PR author is responsible for ensuring the PR gets reviewed, updates get made, and a merge is completed.
  - When creating a PR, either request a review directly in the PR, or request a review in the Eclipse PASS project slack with a link to the PR.
- For PRs created by committers, the PR author is expected to perform the PR merge after another committer has approved the PR.
- For PRs created by contributors, the committer reviewing the PR is responsible for merging the PR after approval.
- Merges from the `main` branch into a development branch should be avoided. Instead, the development branch should be rebased onto `main` so that the final result in a PR is always displaying PR changes directly following the commits currently on `main`.
- A PR should not be merged until all automated checks pass.
- When merging, ensure that the end result will maintain a clean git history.
  - If commits in the PR are well organized and commit messages provide appropriate detail about changes made, using "Rebase and merge" is preferred.
  - If commits in the PR don't meet the criteria for a "Rebase and merge" (e.g. there are many commits and/or commit messages are not descriptive), use "Squash and merge" and provide a commit message which describes the changes made in the PR as a whole.

## Troubleshooting

### Committer Email Address

For official committers, make sure that you configure all eclipse-pass
repos against your contributor email.

For example (please replace with your email):

```bash
git config user.email "jane.url@eclipse-foundation.org"
```

If you have multiple GitHub accounts, you may need to specify the GitHub
username you'd like to use with the repo.

For example (please replace with your GitHub username):

```bash
git config credential.username "jane-doe"
```

If you already have commits against a separate email address, then you
can rebase those commits and change the email:

```bash
git rebase -i origin/main
```

This will show all commits:

```bash
pick bb697d0 Migrate playground docs into main

# Rebase 8d61ffa..bb697d0 onto 8d61ffa (1 command)
#
# Commands:
# p, pick <commit> = use commit
# r, reword <commit> = use commit, but edit the commit message
# e, edit <commit> = use commit, but stop for amending
# s, squash <commit> = use commit, but meld into previous commit
# f, fixup <commit> = like "squash", but discard this commit's log message
# x, exec <command> = run command (the rest of the line) using shell
# b, break = stop here (continue rebase later with 'git rebase --continue')
# d, drop <commit> = remove commit
# l, label <label> = label current HEAD with a name
# t, reset <label> = reset HEAD to a label
# m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
# .       create a merge commit using the original merge commit's
# .       message (or the oneline, if no original merge commit was
# .       specified). Use -c <commit> to reword the commit message.
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
```

Change `pick` to `edit`.  In the example above:

```bash
edit bb697d0 Migrate playground docs into main
```

And then for each commit change the email (please replace with your email):

```bash
git commit --amend --no-edit --author="Jane Url <jane.url@eclipse-foundation.org>"
git rebase --continue
```

And finally, push your changes:

```bash
git push --force-with-lease
```

## Articles

* [PASS Parent POM](/docs/dev/parent-pom.md) - Common deps between Java projects
* [PASS Playground](/docs/dev/playground.md) - Ops playground
* [PASS UI](/docs/dev/pass-ui.md) - PASS Ember application
