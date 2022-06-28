# Self Hosted GitHub Runners

A self-hosted runner is a system that you deploy and manage to execute jobs from GitHub Actions on GitHub.com.
This can be useful for

* running automation scripts
* deploying production / pre-production servers

To use self-hosted runners, you will need to be an administrator of the GitHub project.
If you can access `/settings/actions/runners` then you have the right access permissions.

![GitHub Settings Runners](/docs/assets/github/github_settings_runners.png)

## Create Self-Hosted Runner

You can add an actions runner from the settings page (change the organization/project information)

```
https://github.com/eclipse-pass/pass-docker/settings/actions/runners
```

Please refer to the latest from the settings page, but here is a (slightly modified) copy of the
scripts.

### Download the tools

First we need to download the latest release from GitHub

```bash
mkdir -p /opt/actions-runner
(cd /opt/actions-runner && \
 curl -o actions-runner-linux-x64-2.293.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.293.0/actions-runner-linux-x64-2.293.0.tar.gz && \
 echo "06d62d551b686239a47d73e99a557d87e0e4fa62bdddcf1d74d4e6b2521f8c10  actions-runner-linux-x64-2.293.0.tar.gz" | shasum -a 256 -c && \
 tar xzf ./actions-runner-linux-x64-2.293.0.tar.gz)
```

### Configure Runner

Then we create the runner and start the configuration experience.
The token information will be different.  We also created a
non-sudo user `useradd githubrunner` account to act as the runner.

```bash
sudo -u githubrunner ./config.sh \
  --unattended \
  --url https://github.com/eclipse-pass/pass-docker \
  --token $GITHUB_RUNNER_TOKEN \
  --name passdemo \
  --runnergroup default \
  --labels passdemo \
  --work pass-docker \
  --replace
```

And you will want the runner as a service, which is configured with

```bash
./svc.sh install githubrunner
```

If you want to run it locally, then just run

```bash
./run.sh
```

If you already configured a runner (i.e. the above config.sh fails), you can remove it with

```bash
sudo -u githubrunner ./config.sh remove --token $GITHUB_RUNNER_TOKEN
```

## View Runner via UI

If everything is configured correctly, then you should see the runners (assumes admin user)

```
https://github.com/eclipse-pass/pass-docker/settings/actions/runners
```

![Passdemo runner on GitHub.com](/docs/assets/github/passdemo_runner.png)


## View Runners via API

You can query this information via [GitHub's Self-Hosted Runner APIs](https://docs.github.com/en/rest/actions/self-hosted-runners)

To run the API calls you will need a [Personal Access Token PAT](https://github.com/settings/tokens)
stored in an environment variable

```bash
export GITHUB_TOKEN=ghp_abc123def456abc123def456abc123def456
````

If you configured the above correctly, you should see the You can view existing self-hosted runners with

```
curl \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/repos/eclipse-pass/pass-docker/actions/runners
```


## References

* [Self-Hosted Runner Documentation](https://docs.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners)
* [Adding Self-Hosted Runner](https://docs.github.com/en/actions/hosting-your-own-runners/adding-self-hosted-runners)
* [Self-Hosted Runner APIs](https://docs.github.com/en/rest/actions/self-hosted-runners)