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

Back up the MySQL `webtrees` database and the `data` directory.

```sh
make backup
```

### Recovery steps

Create the `webtrees` database and user.

Modify `data/config.ini.php` with updated configs.

Import the MySQL backup and restore the `data` directory.

In the Docker container, set permissions for the `data` directory.

```sh
chown -R www-data:www-data /var/www/html/data
```


[repo-vps]: https://github.com/tifa/vps
[site]: https://tree.tifa.dev
[wiki-zhuyin]: https://en.wikipedia.org/wiki/Zhuyin
