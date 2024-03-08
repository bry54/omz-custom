# Function to create a Solidity contract file in the 'contracts' folder
function dapp-contract() {
    mkdir -p contracts
    echo "// SPDX-License-Identifier: MIT\npragma solidity ^0.8.0;\n\ncontract $1 {\n  // Add your contract logic here\n}\n" > contracts/$1.sol
    echo "Contract file created successfully."
}

# Function to create a TypeScript test file in the 'test' folder
function dapp-test() {
    mkdir -p test
    echo "import { assert } from 'chai';\nimport { ethers } from 'hardhat';\n\ndescribe('$1 Contract', () => {\n  it('Should deploy $1 contract', async () => {\n    const $1 = await ethers.getContractFactory('$1');\n    const $1Instance = await $1.deploy();\n    await $1Instance.deployed();\n    assert.isTrue($1Instance.address !== '', 'Contract not deployed');\n  });\n});" > test/$1.test.ts
    echo "Test file created successfully."
}

# Function to create both contract and test files for a DApp
function dapp-assets() {
    # Convert the input to camelCase with the first letter as capital
    normalized="$(echo "$1" | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2));}1')"
    
    # Create contract and test files
    dapp-contract "$normalized" && dapp-test "$normalized"

    echo "Assets creation complete for: $normalized"
}
