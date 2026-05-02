new-mbira-project() {
	local MBIRA_PROJECT_HOME="$HOME/AudacityProjects/mbira"

	if [ -z "$1" ]; then
		echo "Usage: new-mbira-project <project-name>"
		return 1
	fi

	local PROJECT_NAME="$1"
	local PROJECT_PATH="$MBIRA_PROJECT_HOME/$PROJECT_NAME"

	mkdir -p "$PROJECT_PATH"/exports

	echo "Folder structure created for '$PROJECT_NAME':"
	if command -v tree &>/dev/null; then
		tree "$PROJECT_PATH"
	else
		ls "$PROJECT_PATH"
	fi
}

alias youtube-downloader='docker run \
    --rm -i \
    -e PGID=$(id -g) \
    -e PUID=$(id -u) \
    -v "$(pwd)":/workdir:rw \
    mikenye/youtube-dl'

youtube-to-audio(){
    if [ $# -ne 2 ]; then
      echo "Usage: youtube-to-audio <source_directory> <destination_directory>"
      return 1
    fi

    local SRC_DIR="$1"
    local DEST_DIR="$2"

    find "$SRC_DIR" -type f \( -iname "*.webm" -o -iname "*.mkv" -o -iname "*.mp4" -o -iname "*.mov" -o -iname "*.avi" \) | while read -r FILE; do
    local REL_PATH="${FILE#$SRC_DIR/}"
    local DEST_FILE="$DEST_DIR/${REL_PATH%.*}.mp3"

    if [ -f "$DEST_FILE" ]; then
        echo "Skipping (already converted): $REL_PATH"
        continue
    fi

    mkdir -p "$(dirname "$DEST_FILE")"

    echo "Converting: $REL_PATH"
    ffmpeg -i "$FILE" -q:a 0 -map a "$DEST_FILE" -y < /dev/null
    done

    echo "Conversion completed!"

    clean-rename "$DEST_DIR"
}

youtube-to-video(){
    if [ $# -ne 3 ]; then
      echo "Usage: youtube-to-video <source_directory> <destination_directory> <format: mp4|mkv>"
      return 1
    fi

    local SRC_DIR="$1"
    local DEST_DIR="$2"
    local FORMAT="$3"

    if [[ "$FORMAT" != "mp4" && "$FORMAT" != "mkv" ]]; then
      echo "Invalid format. Must be 'mp4' or 'mkv'."
      return 1
    fi

    find "$SRC_DIR" -type f \( -iname "*.webm" -o -iname "*.mkv" -o -iname "*.mp4" -o -iname "*.mov" -o -iname "*.avi" -o -iname "*.flv" \) | while read -r FILE; do
      local REL_PATH="${FILE#$SRC_DIR/}"
      local DEST_FILE="$DEST_DIR/${REL_PATH%.*}.$FORMAT"

      if [ -f "$DEST_FILE" ]; then
        echo "Skipping (already converted): $REL_PATH"
        continue
      fi

      mkdir -p "$(dirname "$DEST_FILE")"

      echo "Converting: $REL_PATH → $FORMAT"

      if [ "$FORMAT" = "mp4" ]; then
        ffmpeg -i "$FILE" -c:v libx264 -preset slow -crf 18 -c:a aac -b:a 320k "$DEST_FILE" -y < /dev/null
      else
        ffmpeg -i "$FILE" -c:v libx265 -preset slow -crf 18 -c:a flac "$DEST_FILE" -y < /dev/null
      fi
    done

    echo "Conversion completed!"

    clean-rename "$DEST_DIR"
}

clean-rename(){
    if [ $# -ne 1 ]; then
      echo "Usage: clean-rename <directory>"
      return 1
    fi

    local base_dir="$1"

    if [ ! -d "$base_dir" ]; then
      echo "Error: '$base_dir' is not a directory."
      return 1
    fi

    find "$base_dir" -type f | while read -r file; do
      local dir=$(dirname "$file")
      local name=$(basename "$file")

      local new_name=$(echo "$name" | \
        sed 's/\[[^]]*\]//g' | \
        sed 's/  */ /g' | \
        sed 's/ *$//' | \
        sed 's/ *\.\([^.]*\)$/.\1/')

      if [ "$name" != "$new_name" ]; then
        mv -v "$file" "$dir/$new_name"
      fi
    done
}
