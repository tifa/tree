# tree 🏡

[![Huang-Wen Family Tree](https://img.shields.io/badge/huang/wen-family_tree-cornflowerblue)][site]

Private family genealogy site.

1796 - 2017, Taiwan to USA.

[![Website screenshot](docs/assets/screenshot.png)][site]

## Added Features

- [Zhuyin][wiki-zhuyin] for Traditional Chinese support
- Automatic backups to Google Drive

## Requirements

- Docker
- AWS CLI
- Google Drive OAuth credentials


## Recovery Steps

Set up the [reverse proxy][repo-proxy].

Authenticate using the [AWS CLI][aws-cli] to save MySQL passwords.

```sh
aws configure
aws ssm put-parameter --type SecureString --overwrite \
    --name /app/tree/gdrive_client_id \
    --value <GDRIVE_CLIENT_ID>
aws ssm put-parameter --type SecureString --overwrite \
    --name /app/tree/gdrive_client_secret \
    --value <GDRIVE_CLIENT_SECRET>
aws ssm put-parameter --type SecureString --overwrite \
    --name /app/tree/mysql_password \
    --value <PASSWORD>
aws ssm put-parameter --type SecureString --overwrite \
    --name /app/tree/mysql_root_password \
    --value <PASSWORD>
```

Copy the example environment file and update the configs.

```sh
cp .env.example .env
```

Restore data from an existing backup from Google Drive.

```sh
make restore
```

Build and start the service.

```sh
make start
```


[aws-cli]: https://aws.amazon.com/cli/
[wiki-zhuyin]: https://en.wikipedia.org/wiki/Zhuyin
[repo-proxy]: https://github.com/tifa/proxy
[site]: https://tree.chyouhwu.com
