# tree 🏡

[![Huang-Wen Family Tree](https://img.shields.io/badge/huang/wen-family_tree-cornflowerblue)][site]

Private family genealogy site.

1796 - 2017, Taiwan to USA.

[![Website screenshot](docs/assets/screenshot.png)][site]

## Added Features

- [Zhuyin][wiki-zhuyin] for Traditional Chinese

## Setup

Set up [vps][repo-vps] with reverse proxy.

Copy the example environment file and update the configs.

```sh
cp .env.example .env
```

Build and start the service.

```sh
make start
```

### Backup

Create a tar file of a dump of the `webtrees` database and `data` directory.

### Recovery

Create the `webtrees` database and user.

Import the MySQL backup.

Restore the `data` directory to `./backup/data` and start the service.


[repo-vps]: https://github.com/tifa/vps
[site]: https://tree.tifa.dev
[wiki-zhuyin]: https://en.wikipedia.org/wiki/Zhuyin
