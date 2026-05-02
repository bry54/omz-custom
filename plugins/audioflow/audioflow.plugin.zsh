new-mbira-project() {
	local MBIRA_PROJECT_HOME="$HOME/AudacityProjects/mbira"

	if [ -z "$1" ]; then
		echo "Usage: new-mbira-project <project-name>"
		return 1
	fi

	local PROJECT_NAME="$1"
	local PROJECT_PATH="$MBIRA_PROJECT_HOME/$PROJECT_NAME"

	# Create the folder structure
	#mkdir -p "$PROJECT_PATH"/{exports,kushaura,kutsinhira,combined}
	mkdir -p "$PROJECT_PATH"/exports

	echo "Folder structure created for '$PROJECT_NAME':"
	tree "$PROJECT_PATH"
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
      exit 1
    fi

    SRC_DIR="$1"
    DEST_DIR="$2"

    # Find all video/audio files recursively
    find "$SRC_DIR" -type f \( -iname "*.webm" -o -iname "*.mkv" -o -iname "*.mp4" -o -iname "*.mov" -o -iname "*.avi" \) | while read -r FILE; do
    # Compute relative path (keeps folder structure)
    REL_PATH="${FILE#$SRC_DIR/}"

    # Replace file extension with .mp3
    DEST_FILE="$DEST_DIR/${REL_PATH%.*}.mp3"

    # Skip if already converted
    if [ -f "$DEST_FILE" ]; then
        echo "Skipping (already converted): $REL_PATH"
        continue
    fi

    # Create destination directory if needed
    mkdir -p "$(dirname "$DEST_FILE")"

    echo "Converting: $REL_PATH"

    # Convert to MP3 with high quality (-q:a 0)
    ffmpeg -i "$FILE" -q:a 0 -map a "$DEST_FILE" -y < /dev/null
    done

    echo "Conversion completed!"

    clean-rename "$DEST_DIR"
}

youtube-to-video(){
    # --- Input validation ---
    if [ $# -ne 3 ]; then
      echo "Usage: youtube-to-video <source_directory> <destination_directory> <format: mp4|mkv>"
      exit 1
    fi

    SRC_DIR="$1"
    DEST_DIR="$2"
    FORMAT="$3"

    if [[ "$FORMAT" != "mp4" && "$FORMAT" != "mkv" ]]; then
      echo "Invalid format. Must be 'mp4' or 'mkv'."
      exit 1
    fi

    # --- Conversion loop ---
    find "$SRC_DIR" -type f \( -iname "*.webm" -o -iname "*.mkv" -o -iname "*.mp4" -o -iname "*.mov" -o -iname "*.avi" -o -iname "*.flv" \) | while read -r FILE; do
      # Compute relative path
      REL_PATH="${FILE#$SRC_DIR/}"

      # Replace extension
      DEST_FILE="$DEST_DIR/${REL_PATH%.*}.$FORMAT"

      # Skip if already converted
      if [ -f "$DEST_FILE" ]; then
        echo "Skipping (already converted): $REL_PATH"
        continue
      fi

      # Create destination directory if needed
      mkdir -p "$(dirname "$DEST_FILE")"

      echo "Converting: $REL_PATH → $FORMAT"

      # Choose audio codec based on format
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

    # Check argument
    if [ $# -ne 1 ]; then
      echo "Usage: $0 <directory>"
      exit 1
    fi

    base_dir="$1"

    # Confirm directory exists
    if [ ! -d "$base_dir" ]; then
      echo "Error: '$base_dir' is not a directory."
      exit 1
    fi

    # Loop through all files recursively
    find "$base_dir" -type f | while read -r file; do
      dir=$(dirname "$file")
      name=$(basename "$file")

      # Remove [anything], trim spaces, and fix space-before-dot issue
        new_name=$(echo "$name" | \
          sed 's/\[[^]]*\]//g' | \
          sed 's/  */ /g' | \
          sed 's/ *$//' | \
          sed 's/ *\.\([^.]*\)$/.\1/')  # <-- removes space before extension

      # Skip if same name
      if [ "$name" != "$new_name" ]; then
        mv -v "$file" "$dir/$new_name"
      fi
    done

}
