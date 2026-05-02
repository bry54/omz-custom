# react plugin

This plugin provides shortcuts for scaffolding React, React Native, and Next.js applications.

To use it, add `react` to the plugins array in your zshrc file:

```zsh
plugins=(... react)
```

Requires `node`, `npx`, and `yarn` to be installed and an internet connection.

---

## Commands

| Command | Description |
| :--- | :--- |
| `new-react-app <name>` | Creates a new React app using `create-react-app` with the TypeScript template |
| `new-next-app <name>` | Creates a new Next.js app using `create-next-app` with TypeScript |
| `new-rn-app <name>` | Creates a new bare React Native app using `react-native init` |
| `new-rn-expo-app <name>` | Creates a new React Native app using `yarn create expo-app` |
