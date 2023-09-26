# Bitwarden

A [password tool](https://bitwarden.com) to help us manage our [organizations secrets](https://vault.bitwarden.com/#/vault?organizationId=e429b264-5b49-4794-be50-b0660125456a).
Another potential tool is the [pass CLI](https://www.passwordstore.org) where `pass` is for password not _our_ Open Access PASS.

Here is an outline of passwords we are tracking
(duplicating here as can better document the integrations with other services
like [Otterdog](/docs/infra/otterdog.md) and Github Actions).

![Bitwarden Secrets User Interface](/docs/assets/bitwarden/ui.png)

| Secret | Description |
| --- | --- |
| HELLO_WORLD | A test secret for demontsrating how secrets are managed |


## Installing CLI

Some instructions for installing the [bitwarden cli are here](https://github.com/bitwarden/clients).
The tools command line name is `bw` and you can see which version you are running with

```bash
bw -v
```

To install it via [homebrew](https://brew.sh) you can run

```bash
brew install bitwarden-cli
```
