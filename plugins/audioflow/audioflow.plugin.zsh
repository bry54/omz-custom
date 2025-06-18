new-mbira-project() {
	local MBIRA_PROJECT_HOME="$HOME/AudacityProjects/mbira"

	if [ -z "$1" ]; then
		echo "Usage: new-mbira-project <project-name>"
		return 1
	fi

	local PROJECT_NAME="$1"
	local PROJECT_PATH="$MBIRA_PROJECT_HOME/$PROJECT_NAME"

	# Create the folder structure
	mkdir -p "$PROJECT_PATH"/{combined,kushaura,kutsinhira}

	echo "Folder structure created for '$PROJECT_NAME':"
	tree "$PROJECT_PATH"
}

alias yt-dl='docker run \
    --rm -i \
    -e PGID=$(id -g) \
    -e PUID=$(id -u) \
    -v "$(pwd)":/workdir:rw \
    mikenye/youtube-dl'

