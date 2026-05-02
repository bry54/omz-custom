# laravel plugin

This plugin provides shortcuts for bootstrapping new Laravel projects and a convenience alias for Laravel Sail.

To use it, add `laravel` to the plugins array in your zshrc file:

```zsh
plugins=(... laravel)
```

Requires an internet connection to create projects. `new-laravel-sail-app` requires `curl` and `bash`. `new-laravel-composer-app` requires the `composer` alias (available via the `workflow` plugin or a local Composer install).

---

## Commands

| Command | Description |
| :--- | :--- |
| `new-laravel-sail-app <name>` | Creates a new Laravel project using the official Laravel Sail installer. Includes `mysql`, `redis`, and `mailpit` by default. |
| `new-laravel-composer-app <name>` | Creates a new Laravel project using `composer create-project laravel/laravel`. |

---

## Aliases

| Alias | Command | Description |
| :--- | :--- | :--- |
| `sail` | `sh vendor/bin/sail` | Runs Laravel Sail. Uses a local `sail` script if present, otherwise falls back to `vendor/bin/sail`. |
