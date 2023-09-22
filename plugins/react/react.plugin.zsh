# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.
new-rn-app () {
    if [ -z "$1" ]; then
        echo "Please provide app name."
    else
        npx react-native init $1
    fi
}

new-rn-expo-app () {
    if [ -z "$1" ]; then
        echo "Please provide app name."
    else
        yarn create expo-app $1
    fi
}

new-react-app () {
    if [ -z "$1" ]; then
        echo "Please provide app name."
    else
        npx create-react-app $1 --template typescript
    fi
}

new-next-app () {
    if [ -z "$1" ]; then
        echo "Please provide app name."
    else
        npx create-next-app@latest --typescript $1
    fi
}