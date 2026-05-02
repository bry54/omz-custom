# fly-exec plugin

This plugin lets you execute code inside isolated Docker containers without installing runtimes locally. Each function mounts your project directory and drops you into an interactive shell.

To use it, add `fly-exec` to the plugins array in your zshrc file:

```zsh
plugins=(... fly-exec)
```

Requires `docker` to be installed and running.

---

## Supported Environments

| Command | Docker Image | Exposed Port | Description |
| :--- | :--- | :--- | :--- |
| `fly-exec-java <dir>` | `openjdk:8` | — | Interactive Bash shell in a Java 8 environment |
| `fly-exec-node <dir>` | `node:lts` | — | Interactive Bash shell in a Node.js LTS environment |
| `fly-exec-go` | `golang:1.22` | — | Interactive Bash shell in a Go 1.22 environment (uses `$PWD`) |
| `fly-exec-php <dir>` | `php:latest` | `8080` | Interactive Bash shell in a PHP environment |
| `fly-exec-nginx <dir>` | `nginx` | `8080` | Serves static files from `<dir>` via Nginx (detached) |
| `fly-exec-apache <dir>` | `httpd:2.4` | `8080` | Serves static files from `<dir>` via Apache 2.4 (detached) |
