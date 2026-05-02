# helpers plugin

This plugin provides general-purpose shell utilities for downloading, file management, renaming, and Docker container access.

To use it, add `helpers` to the plugins array in your zshrc file:

```zsh
plugins=(... helpers)
```

Requires `curl`, `wget`, `bc`, `docker`, and `md5` to be available on `$PATH`.

---

## Downloads

| Command | Description |
| :--- | :--- |
| `getcontentlength <url>` | Fetches the `Content-Length` header for a URL and displays the file size in MB. Prompts to download the file with a custom save path and filename. |
| `batch-wget <dir>` | Reads `<dir>/paths.txt` (format: `<url> <relative-dest>`) and downloads each file into `<dir>`. Skips files that already exist. |

---

## File Management

| Command | Description |
| :--- | :--- |
| `bulkextensiontransformer <dir> <old-ext> <new-ext>` | Recursively renames all `.<old-ext>` files to `.<new-ext>` under `<dir>`. Also renames files with no extension to `.<new-ext>`. |
| `exportdirfiles <dir>` | Recursively lists all files under `<dir>` and writes a CSV (`Name`, `Size (MB)`, `Path`) to `~/Downloads/what-we-do/output.csv` |

---

## Utilities

| Command | Description |
| :--- | :--- |
| `generatemd5` | Generates a random 32-character hex string from `/dev/urandom` |
| `container-shell <container>` | Opens an interactive shell in a running Docker container. Tries `/bin/zsh` first, falls back to `/bin/bash`. |
