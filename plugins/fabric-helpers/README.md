# fabric-helpers plugin

This plugin provides helpers for Hyperledger Fabric development — environment setup, chaincode scaffolding, peer operations, and network management.

Originally developed during a Masters Thesis project.

To use it, add `fabric-helpers` to the plugins array in your zshrc file:

```zsh
plugins=(... fabric-helpers)
```

Requires `go`, `node`, `jq`, and Hyperledger Fabric binaries. Run `hf.init` first to configure the environment.

---

## Environment

| Command | Description |
| :--- | :--- |
| `hf.init --uname <user> --project <project>` | Initialises the Fabric environment. Sets `HF_USERNAME`, `HF_PROJECT`, `HF_SAMPLES`, `HF_BINARIES`, `FABRIC_CFG_PATH`, and `HF_NETWORK_DIR`. Adds binaries to `$PATH`. |

---

## Network

| Command | Description |
| :--- | :--- |
| `network.sh <args>` | Proxies to `$HF_NETWORK_DIR/network.sh` with the provided arguments. Run `network.sh -h` for all available commands. |
| `hf.monitor.network` | Starts the Docker network monitor for the `fabric_test` network |

---

## Chaincode

| Command | Description |
| :--- | :--- |
| `hf.new.chaincode <asset-name>` | Scaffolds a new TypeScript chaincode package under `$HF_SAMPLES/$HF_PROJECT/chaincode/`. Creates asset, contract, test, and index files from templates. |
| `hf.deploy.chaincode <name> <path> <version> <channel>` | Deploys a chaincode to the network via `network.sh deployCC` |

---

## Peer Operations

| Command | Description |
| :--- | :--- |
| `hf.use.org1` | Sets peer environment variables to target Org1 (port 7051) |
| `hf.use.org2` | Sets peer environment variables to target Org2 (port 9051) |
| `hf.peer.approve <name> <version> <channel> <sequence>` | Approves and commits a chaincode for both Org1 and Org2. Prompts for the package ID interactively. |
| `hf.peer.invoke <channel> <chaincode> <function> <args>` | Queries a chaincode function on the specified channel |

---

## Utilities

| Command | Description |
| :--- | :--- |
| `kebab_to_camel <string>` | Converts `kebab-case` to `camelCase` |
| `camel_to_pascal <string>` | Converts `camelCase` to `PascalCase` |
