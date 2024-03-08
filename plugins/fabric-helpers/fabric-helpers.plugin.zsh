function hf.init(){
    local username
    local project

    # Parse named parameters
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --uname) username="$2"; shift ;;
            --project) project="$2"; shift ;;
            *) echo "Usage: hf.env --uname <username> --project <project-name>" >&2; return 1 ;;
        esac
        shift
    done

    # Validate required parameters
    if [ -z "$username" ] || [ -z "$project" ]; then
        echo "Usage: hf.env --uname <username> --project <project-name>" >&2
        return 1
    fi

    export HF_USERNAME="$username"
    export HF_PROJECT="$project"
    export HF_SAMPLES="$HOME/go/src/github.com/$HF_USERNAME/fabric-samples"
    export HF_BINARIES="${HF_SAMPLES}/bin"
    export FABRIC_CFG_PATH="${HF_SAMPLES}/config"
    export HF_NETWORK_DIR="${HF_SAMPLES}/test-network"

    if [[ ":$PATH:" != *":${HF_BINARIES}:"* ]]; then
        export PATH="$PATH:${HF_BINARIES}"
    fi

    source "$HOME/.zshrc"

    echo "Environment initialized:"
    echo "HF_USERNAME=$HF_USERNAME"
    echo "HF_PROJECT=$HF_PROJECT"
    echo "HF_BINARIES=$HF_BINARIES"
    echo "HF_CONFIGS=$FABRIC_CFG_PATH"
    echo "HF_NETWORK_DIR=$HF_NETWORK_DIR"

    cd "$HF_SAMPLES/$HF_PROJECT"
}

network.sh() {
    # Path to the network.sh script
    script_path="$HF_NETWORK_DIR/network.sh"

    # Check if the script exists
    if [ ! -f "$script_path" ]; then
        echo "Network script not found at: $script_path"
        return 1
    fi

    # Check if any parameters are provided
    if [ "$#" -eq 0 ]; then
        echo "Usage: hf-network -h to show all the commands executable on hyperledger network"
        return 1
    fi

    # Execute the network.sh script with provided parameters
    "$script_path" "$@"
}

hf.monitor.network(){
    # Path to the network.sh script
    script_path="$HF_NETWORK_DIR/monitordocker.sh"

    # Check if the script exists
    if [ ! -f "$script_path" ]; then
        echo "Network monitor script not found at: $script_path"
        return 1
    fi

    # Execute the network.sh script with provided parameters
    "$script_path" "fabric_test"
}

hf.use.org1(){
    # Environment variables for Org1

    export CORE_PEER_TLS_ENABLED=true
    export CORE_PEER_LOCALMSPID="Org1MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=${HF_NETWORK_DIR}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
    export CORE_PEER_MSPCONFIGPATH=${HF_NETWORK_DIR}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
    export CORE_PEER_ADDRESS=localhost:7051
}

hf.use.org2(){
    # Environment variables for Org2

    export CORE_PEER_TLS_ENABLED=true
    export CORE_PEER_LOCALMSPID="Org2MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=${HF_NETWORK_DIR}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
    export CORE_PEER_MSPCONFIGPATH=${HF_NETWORK_DIR}/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
    export CORE_PEER_ADDRESS=localhost:9051
}


