# Bitwarden

A [password tool](https://bitwarden.com) to help us manage our [organizations secrets](https://vault.bitwarden.com/#/vault?organizationId=e429b264-5b49-4794-be50-b0660125456a).
Another potential tool is the [pass CLI](https://www.passwordstore.org) where `pass` is for password not _our_ Open Access PASS.

Here is an outline of passwords we are tracking
(duplicating here as can better document the integrations with other services
like [Otterdog](/docs/infra/otterdog.md) and Github Actions).

![Bitwarden Secrets User Interface](/docs/assets/bitwarden/ui.png)

| Item Name | Item Id | Field | Description |
| --- | --- | --- | --- |
| HELLO_WORLD | 23801ca4-fd27-446c-b5af-b07b0108f443 | quest | A test secret of `holy_grail` for demontsrating how secrets are managed |
| HELLO_WORLD | 23801ca4-fd27-446c-b5af-b07b0108f443 | color | Another test secret of `blue_no_ahh` |

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

You can log into the account with

```bash
bw login
```

And then you can list the passwords (in plain text, be careful).

```bash
bw list items --search HELLO_WORLD
```

Note these are NOT sensitive passwords so it's OK to be shown

```bash
[
    {
        "passwordHistory":
        [
            {
                "lastUsedDate": "2023-09-26T17:32:20.947Z",
                "password": "HELLO_WORLD"
            }
        ],
        "revisionDate": "2023-09-26T17:39:02.833Z",
        "creationDate": "2023-09-12T16:04:39.793Z",
        "deletedDate": null,
        "object": "item",
        "id": "23801ca4-fd27-446c-b5af-b07b0108f443",
        "organizationId": "e429b264-5b49-4794-be50-b0660125456a",
        "folderId": null,
        "type": 1,
        "reprompt": 0,
        "name": "HELLO_WORLD",
        "notes": null,
        "favorite": false,
        "fields":
        [
            {
                "name": "quest",
                "value": "holy_grail",
                "type": 1,
                "linkedId": null
            },
            {
                "name": "color",
                "value": "blue_no_ahh",
                "type": 1,
                "linkedId": null
            }
        ],
        "login":
        {
            "username": null,
            "password": "WORLD_HELLO",
            "totp": null,
            "passwordRevisionDate": "2023-09-26T17:32:20.947Z"
        },
        "collectionIds":
        [
            "af5a75d8-8762-4cec-8d96-b06601263cf1"
        ]
    }
]
```


## Troubleshooting

### How do I get the ID of an item from the UI

You will need to **Inspect** the page and watch for the network traffic
after you edit the item.

![Bitwarden Secrets User Interface](/docs/assets/bitwarden/ui_get_id.png)

