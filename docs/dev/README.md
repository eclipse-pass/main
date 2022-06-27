# Developer Documentation

Developer focused documentation should be written in this `docs/dev/` directory. Separate documentation pages can be added in this directory and referenced here. If a given component has many documentation pages, please add a directory for it within the [docs/dev/](/docs/dev) directory.

## Components

| Component | Summary | Repo | Docs |
| --- | --- | --- | --- |
| Playground | A collection of small `hello-world` like applications written in the technologies being used with eclipse-pass | [/eclipse-pass/playground](https://github.com/eclipse-pass/playground) | [/docs/playground.md](/docs/dev/playground.md) |
| Pass UI | The PASS web application | [/eclipse-pass/pass-ui](https://github.com/eclipse-pass/pass-ui) | [/docs/pass-ui.md](/docs/dev/pass-ui.md) |

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
