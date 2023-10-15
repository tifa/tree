# tree 🏡

[![Huang-Wen Family Tree](https://img.shields.io/badge/huang/wen-family_tree-cornflowerblue)][site]

Private family genealogy site.

1796 - 2017, Taiwan to USA.

[![Website screenshot](docs/assets/screenshot.png)][site]

## Added Features

- [Zhuyin][wiki-zhuyin] for Traditional Chinese


## Recovery Steps

Set up the [reverse proxy][repo-proxy].


Copy the example environment file and update the configs.

```sh
cp .env.example .env
```

Build and start the service.

```sh
make start
```


[wiki-zhuyin]: https://en.wikipedia.org/wiki/Zhuyin
[repo-proxy]: https://github.com/tifa/proxy
[site]: https://tree.chyouhwu.com
