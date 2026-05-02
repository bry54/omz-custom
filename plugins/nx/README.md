# nx plugin

This plugin provides shortcuts for creating and configuring Nx monorepo workspaces with NestJS.

To use it, add `nx` to the plugins array in your zshrc file:

```zsh
plugins=(... nx)
```

Requires `node`, `npx`, and `yarn` to be installed and an internet connection to create workspaces.

---

## Workspace

| Command | Description |
| :--- | :--- |
| `nx-new-workspace <name>` | Creates a new Nx workspace using `npx create-nx-workspace` and navigates into it |

---

## Package Shortcuts

| Command | Description |
| :--- | :--- |
| `nx-add-core-packages` | Adds core NestJS packages: `@nestjs/config`, `joi`, `typeorm-naming-strategies`, `bcrypt` |
| `nx-add-graphql` | Adds GraphQL packages: `@nestjs/graphql`, `graphql-tools`, `graphql`, `apollo-server-express` |
| `nx-add-restful` | Adds RESTful CRUD packages: `@nestjsx/crud`, `class-transformer`, `class-validator`, `@nestjsx/crud-typeorm`, `@nestjs/typeorm`, `typeorm`, `@nestjs/swagger` |

---

## Generators

| Command | Description |
| :--- | :--- |
| `nx-add-app <name>` | Generates a new NestJS app inside the Nx workspace |
| `nx-add-nest-lib <name>` | Generates a new NestJS library inside the Nx workspace |
