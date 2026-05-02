# eros plugin

This plugin provides tools for managing private media collections — bulk renaming, video/image collection, and running a self-hosted Stash server via Docker.

To use it, add `eros` to the plugins array in your zshrc file:

```zsh
plugins=(... eros)
```

Requires `docker` to be installed. The `eros-video-collect` command depends on `bulkextensiontransformer` from the `helpers` plugin.

---

## Collection

| Command | Description |
| :--- | :--- |
| `eros-video-collect <src> <dest>` | Converts `.vid` and `.mp4` files to `.eros` format, bulk-renames them with random MD5 hashes, and moves them to `<dest>`. Cleans up empty source folders. |
| `eros-image-collect <src> <dest>` | Zips each subfolder in `<src>` into a randomly named `.zip` file, moves it to `<dest>`, and removes the original folder. Logs mappings to `img-collection.log`. |
| `erosbulkrename <src> <dest>` | Renames all `.eros` files in `<src>` with random MD5 hashes and moves them to `<dest>`. Logs old → new name mappings to `vid-collection.log`. |

---

## Server

| Command | Description |
| :--- | :--- |
| `erosserve <dir>` | Starts a [Stash](https://github.com/stashapp/stash) server on port `9999` via Docker. Expects `config/`, `data/`, `metadata/`, `cache/`, `blobs/`, and `generated/` subdirectories under `<dir>`. |

---

## Utilities

| Command | Description |
| :--- | :--- |
| `erosmockup <dir>` | Creates a test fixture of 5 folders with 3 `.eros` files each under `<dir>` |
| `md5string` | Generates a random 32-character hex string |
