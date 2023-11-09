# Developer Documentation

Developer focused documentation should be written in this `docs/dev/` directory. Separate documentation pages can be added in this directory and referenced here. If a given component has many documentation pages, please add a directory for it within the [docs/dev/](.) directory.

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


## Articles

* [PASS Demo Setup](local_demo.md) - Setting Up a Local Demo System
* [PASS Parent POM](parent-pom.md) - Common deps between Java projects
* [PASS Playground](playground.md) - Ops playground
* [PASS UI](pass-ui.md) - PASS Ember application
* [Troubleshooting](troubleshooting.md) - Common errors and how to fix them
* [Docker Dependencies](integration-test-docker-dependencies.md) - Integration Testing and Docker Dependencies
* [Components](components.md) - PASS project components
* [Releasing PASS](release.md) - Releasing the PASS project
* [Data model](model/README.md) - Data model of the PASS project
