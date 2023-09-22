# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.
#
new-project () {
    projectName="$1"
    basePath="$2"

    if [ -n "$basePath" ]; then
        projectPath="$basePath"
    fi

    if [ -n "$projectName" ]; then
       projectPath="~/Development/Personal/$projectName" 
    fi 
    
    eval mkdir -p $projectPath/{Documents,Code,Assets,Notes,Archives}
}

new-client () {
    clientName="$1"
    projectName=""

    if [ -z "$clientName" ]; then
        echo "Please provide client name."
    else
        basePath="~/Development/Work/$clientName"
        eval mkdir -p "$basePath"
        new-project "$projectName" "$basePath"
    fi
}

alias personal-projects="cd ~/Development/Personal/"
alias work-projects="~/Development/Work/"
