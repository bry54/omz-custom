# Workflow plugin

This plugin provides scaffolding, navigation, and git shortcuts for the CosmaKeri development workflow.

```zsh
plugins=(... workflow)
```

## Installation

```zsh
cp workflow.plugin.zsh ~/.oh-my-zsh/custom/plugins/workflow/
```

Then add `workflow` to your plugins list in `~/.zshrc` and reload:

```zsh
source ~/.zshrc
```

---

## Scaffold

| Command | Description |
| :--- | :--- |
| `new-ck-project <repo>` | Creates a new CosmaKeri product under `~/Dev/CosmaKeri/Code/`. Enforces `ck-` prefix. Initialises git with first commit. |
| `new-client <Name>` | Creates a new client folder under `~/Dev/Clients/` with `Code/`, `Documents/`, and `Design/` subfolders. |
| `new-client-project <Name> <type>` | Creates a new repo inside an existing client's `Code/` folder. Enforces `client-name-type` naming convention. Initialises git with first commit. |
| `new-personal-project <name>` | Creates a new personal project under `~/Dev/Personal/` with `Code/` and `Documents/` subfolders. |

### Project types for `new-client-project`

| Type | Description |
| :--- | :--- |
| `frontend` | React application |
| `backend` | NestJS API |
| `admin` | Admin dashboard |
| `mobile` | Mobile application |
| `api` | Standalone API |
| `docs` | Documentation |

---

## Navigation

| Alias | Description |
| :--- | :--- |
| `dev` | Navigate to `~/Dev` |
| `ck` | Navigate to `~/Dev/CosmaKeri` |
| `ck-code` | Navigate to `~/Dev/CosmaKeri/Code` |
| `ck-docs` | Navigate to `~/Dev/CosmaKeri/Documents` |
| `ck-design` | Navigate to `~/Dev/CosmaKeri/Design` |
| `clients` | Navigate to `~/Dev/Clients` |
| `personal` | Navigate to `~/Dev/Personal` |

---

## Overview

| Command | Description |
| :--- | :--- |
| `ck-list` | Lists all CosmaKeri projects, clients with their repos, and personal projects |
| `ck-open <repo>` | Opens a CosmaKeri repo in VS Code |
| `ck-open <Client> <type>` | Opens a client project in VS Code |
| `ck-help` | Prints all available commands |

---

## Git

| Alias | Command | Description |
| :--- | :--- | :--- |
| `gs` | `git status` | Show working tree status |
| `gl` | `git log --oneline --graph --decorate -10` | Show last 10 commits as graph |
| `gp` | `git push` | Push to remote |
| `gpl` | `git pull` | Pull from remote |
| `gco` | `git checkout` | Checkout branch or file |
| `gcb` | `git checkout -b` | Create and checkout new branch |
| `gaa` | `git add .` | Stage all changes |
| `gcm` | `git commit -m` | Commit with message |

---

## Docker

| Alias | Description |
| :--- | :--- |
| `aws <command>` | Runs AWS CLI via Docker — executes supplied command |
| `composer <command>` | Runs Composer via Docker — executes supplied command |

---

## Folder Structure

This plugin assumes the following structure under `~/Dev`:

```
~/Dev/
├── CosmaKeri/
│   ├── Code/
│   ├── Documents/
│   └── Design/
├── Clients/
│   └── ClientName/
│       ├── Code/
│       ├── Documents/
│       └── Design/
└── Personal/
```

---

## Repo Naming Convention

| Prefix | Usage |
| :--- | :--- |
| `ck-` | CosmaKeri own products e.g. `ck-pay`, `ck-website` |
| `client-` | Client work e.g. `client-acme-frontend`, `client-acme-backend` |
