## GitHub Secrets

GitHub secrets are intended for use by GitHub Actions workflows. If you want a workflow to interact with something that requires authentication, you will likely need to create a secret which will allow authentication to happen securely without making any private information available to anybody having access to the repositories.

There are two levels that GitHub secrets can exist at: organization and repo.

An organization secret belongs to the `eclipse-pass` organization and is available to workflows that are part of any repository that exists under the `eclipse-pass` organization. Secrets that will be used across many repositories should be placed here to prevent duplication.

A repository secret exists within that repository and can only be used by workflows belonging to that repository.

### Creating Secrets

GitHub offers two mechanisms for creating secrets: UI and API.

The GitHub UI requires that a person creating a secret have admin privileges for that entity (either org or repo). Since members of the PASS project don't have admin privileges at any level, we need to open a ticket with Eclipse to add secrets through the UI.

Oddly, the GitHub API allows the creation of repository secrets with `repo` privileges. All members of the PASS project should have sufficient privileges to do so.

To create a repository secret, use the [github_secrets.py script](/tools/github_secrets.py) in this repo like so:
```
    python github_secrets.py -u <username> -t <token> -r <repo> -n <name> -v <value>
```
* username: Your GitHub username
* token: A GitHub personal access token with 'repo' access
* repo: The name of the GitHub repository containing the secret
* name: Name of the secret being created or updated
* value: The value to be set for the secret. The value will be encrypted before being sent to GitHub.

To create an organization secret, a ticket must be opened with the [Eclipse Help Desk](https://gitlab.eclipse.org/eclipsefdn/helpdesk).

### Reading Secrets

The value of a secret can only be read by GitHub Actions workflows.

The metadata associated with a secret can be retrieved with the `github_secrets.py` script by omitting the `value`. The returned data includes the secret's `name`, `created_at`, and `updated_at`. This is primarily useful for verifying that a secret exists where you expect it to be.