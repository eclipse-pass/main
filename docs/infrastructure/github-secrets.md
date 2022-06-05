## GitHub Secrets

GitHub secrets are intended for use by GitHub Actions workflows. If you want a workflow to interact with something that requires authentication, you will likely need to create a secret which will allow authentication to happen securely without making any private information available to anybody having access to the repositories.

There are three levels that GitHub secrets can exist at: organization, repo, and environment.

An organization secret belongs to the `eclipse-pass` organization and is available to workflows that are part of any repository that exists under the `eclipse-pass` organization. Secrets that will be used across many repositories should be placed here to prevent duplication.

A repository secret exists within that repository and can only be used by workflows belonging to that repository.

An environment secret exists within a specific environment within a repository. It can only be used by workflows belonging to that repository and the workflow must specify the environment that it's using.

### Creating Secrets

GitHub offers two mechanisms for creating secrets: UI and API.

The GitHub UI requires that a person creating a secret have admin privileges for that entity (either org or repo). Since members of the PASS project don't have admin privileges at any level, we need to open a ticket with Eclipse to add secrets through the UI.

Oddly, the GitHub API allows the creation of repository secrets with `repo` privileges. All members of the PASS project should have sufficient privileges to do so.

To create a repository or environment secret, use the [github_secrets.py script](/tools/github_secrets.py) in this repo like so:
```
python github_secrets.py -u <username> -t <token> -r <repo> -n <name> -v <value> [-e <environment>]
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

### Secrets in GitHub Actions workflows

To access a GitHub secret from a top-level workflow, you can reference it from within the secrets context like this:
```
${{ secrets.KUBE_CONFIG }}
```

If you want to use a secret in a reusable or "called" workflow, you must pass the secrets that will be used. To do this, when you reference the workflow you additionally provide a `secrets` property containing a list of the secrets that must be passed.

In this example two secrets, KUBE_CONFIG and DIGITALOCEAN_ACCESS_TOKEN are being passed to the `html-app-publish.yml` workflow:

```
call-publish-docker:
    name: Build and Publish Docker image
    uses: eclipse-pass/playground/.github/workflows/html-app-publish.yml@main
    secrets:
    KUBE_CONFIG: ${{ secrets.KUBE_CONFIG }}
    DIGITALOCEAN_ACCESS_TOKEN: ${{ secrets.DIGITALOCEAN_ACCESS_TOKEN }}
```

Within the called workflow, you must declare the secrets that can be expected like this:

```
on:
    workflow_call:
    secrets:
    KUBE_CONFIG:
        required: true
        description: Configuration info for test k8s cluster
    DIGITALOCEAN_ACCESS_TOKEN:
        required: true
        description: Access token for Digital Ocean
```

The secret can now be referenced within the workflow as it would be from a top-level workflow:

```
${{ secrets.KUBE_CONFIG }}
```
