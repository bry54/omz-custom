# workflow plugin

This plugin provides scaffolding, navigation, and git shortcuts for the CosmaKeri development workflow.

To use it, add `workflow` to the plugins array in your zshrc file:

```zsh
plugins=(... workflow)
```

---

## Bootstrap

| Command | Description |
| :--- | :--- |
| `ck-bootstrap` | Creates the full CosmaKeri directory structure from scratch under `~/Development/` |

---

## Scaffold — CosmaKeri

| Command | Description |
| :--- | :--- |
| `ck-new-project <repo>` | Creates a new flat CK repo under `CK/Code/`. Enforces `ck-` prefix. Initialises git with first commit. |
| `ck-new-template <repo>` | Creates a new reusable starter under `CK/Code/Templates/`. Enforces `ck-template-` prefix. Initialises git with first commit. |
| `ck-new-product <Product> <type>` | Creates a new repo under `CK/Code/Products/<Product>/`. Named `ck-<product>-<type>`. Initialises git with first commit. |

### Types for `ck-new-product`

| Type | Description |
| :--- | :--- |
| `backend` | NestJS API |
| `frontend` | React application |
| `admin` | Admin dashboard |
| `mobile` | Mobile application |
| `api` | Standalone API |
| `docs` | Documentation |
| `infra` | Infrastructure / DevOps |

---

## Scaffold — Clients

| Command | Description |
| :--- | :--- |
| `ck-new-client <Name>` | Creates a new client folder under `Clients/` with `Code/`, `Documents/`, and `Design/` subfolders |
| `ck-new-client-project <Name> <type>` | Creates a new repo inside an existing client's `Code/` folder. Named `client-<name>-<type>`. Initialises git with first commit. |

### Types for `ck-new-client-project`

| Type | Description |
| :--- | :--- |
| `frontend` | React application |
| `backend` | NestJS API |
| `admin` | Admin dashboard |
| `mobile` | Mobile application |
| `api` | Standalone API |
| `docs` | Documentation |

---

## Scaffold — Personal

| Command | Description |
| :--- | :--- |
| `new-personal-project <name>` | Creates a new personal project under `~/Development/Personal/Code/`. Initialises git. |

---

## Navigation

| Alias | Path |
| :--- | :--- |
| `dev` | `~/Development` |
| `ck` | `~/Development/CosmaKeri/CK` |
| `ck-code` | `~/Development/CosmaKeri/CK/Code` |
| `ck-templates` | `~/Development/CosmaKeri/CK/Code/Templates` |
| `ck-products` | `~/Development/CosmaKeri/CK/Code/Products` |
| `ck-docs` | `~/Development/CosmaKeri/CK/Documents` |
| `ck-design` | `~/Development/CosmaKeri/CK/Design` |
| `ck-clients` | `~/Development/CosmaKeri/Clients` |
| `personal` | `~/Development/Personal` |

---

## Overview

| Command | Description |
| :--- | :--- |
| `ck-list` | Lists all CK repos (flat, templates, products), clients with their repos, and personal projects |
| `ck-open ck-<repo>` | Opens a flat CK repo in VS Code |
| `ck-open template <name>` | Opens `Templates/ck-template-<name>` in VS Code |
| `ck-open product <Product> <type>` | Opens `Products/<Product>/ck-<product>-<type>` in VS Code |
| `ck-open client <Client> <type>` | Opens `Clients/<Client>/Code/client-<name>-<type>` in VS Code |
| `ck-help` | Prints all available commands |

---

## Git

| Alias | Command | Description |
| :--- | :--- | :--- |
| `gs` | `git status` | Show working tree status |
| `gl` | `git log --oneline --graph --decorate -10` | Show last 10 commits as a graph |
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
| `aws <command>` | Runs AWS CLI via Docker |
| `composer <command>` | Runs Composer via Docker |

---

## Directory Structure

```
~/Development/
├── CosmaKeri/
│   ├── CK/
│   │   ├── Code/
│   │   │   ├── Templates/        ck-template-* starters
│   │   │   ├── Products/         multi-repo sub-brands
│   │   │   │   └── Pay/
│   │   │   │       └── ck-pay-*  backend, frontend, admin, infra
│   │   │   └── ck-*              flat single repos (ck-website, ck-infra)
│   │   ├── Documents/
│   │   │   ├── Legal/
│   │   │   ├── Finance/
│   │   │   ├── Admin/
│   │   │   └── Proposals/
│   │   └── Design/
│   │       ├── Logos/
│   │       ├── Brand/
│   │       └── Marketing/
│   └── Clients/
│       └── ClientName/
│           ├── Code/             client-name-* repos
│           ├── Documents/
│           │   ├── Contracts/
│           │   ├── Proposals/
│           │   ├── Invoices/
│           │   └── Notes/
│           └── Design/
│               ├── Mockups/
│               ├── Assets/
│               └── Guidelines/
└── Personal/
    ├── Code/
    └── Documents/
```

---

## Naming Conventions

| Prefix | Usage |
| :--- | :--- |
| `ck-` | CosmaKeri flat repos — `ck-website`, `ck-infra`, `ck-docs` |
| `ck-template-` | Reusable starters — `ck-template-nestjs`, `ck-template-react` |
| `ck-<product>-` | Product repos — `ck-pay-backend`, `ck-pay-frontend` |
| `client-` | Client work — `client-acme-frontend`, `client-acme-backend` |
