function hf-env(){
    export HF_USERNAME="$1"
    export HF_WORKDIR="$2"

    source "$HOME/.zshrc"
}

function hf-workdir() {
    # Check if the environment variable HF_USERNAME is set
    if [ -z "$HF_USERNAME" ]; then
        echo "username not set for hyperledger fabric envirionment. Set it up using hf-env"
        return 1
    fi

    # Check if the environment variable HF_WORKDIR is set
    if [ -z "$HF_WORKDIR" ]; then
        echo "Project directory not set for hyperledger fabric envirionment. Set it up using hf-env"
        return 1
    fi
    cd "$HOME/go/src/github.com/$HF_USERNAME/fabric-samples/$HF_WORKDIR"
}

network.sh() {
    # Check if the environment variable HF_USERNAME is set
    if [ -z "$HF_USERNAME" ]; then
        echo "Username not set for Hyperledger Fabric environment. Set it up using hf-env."
        return 1  # Return a non-zero status code to indicate failure
    fi

    # Path to the network.sh script
    script_path="$HOME/go/src/github.com/$HF_USERNAME/fabric-samples/test-network/network.sh"

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