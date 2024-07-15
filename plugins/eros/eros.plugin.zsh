bulkerosrname(){
    # Directory containing files to be renamed
    directory="$1"

    # Check if the directory exists
    if [ ! -d "$directory" ]; then
        echo "Directory '$directory' not found."
        return 1
    fi

    # Iterate over each file in the directory and its subdirectories
    find "$directory" -type f -print0 | while IFS= read -r -d '' file; do
        # Generate a random MD5 string
        random_md5=$(md5string)

        # Get the file extension
        extension="${file##*.}"

        # Rename the file with the random MD5 string and original extension
        mv "$file" "${file%/*}/$random_md5.$extension"

        # Print the old and new file names
        echo "Renamed '$file' to '${file%/*}/$random_md5.$extension'"
    done

    echo "All files renamed successfully."
}

# Function to generate random MD5 string
md5string() {
    #echo -n "$(date +%s%N)$RANDOM" | md5
    cat /dev/urandom | LC_CTYPE=C tr -dc 'a-f0-9' | head -c 32 | md5
}

starteros(){
  EROS_HOME="$1"
  
  # Check if the directory exists
  if [ ! -d "$EROS_HOME" ]; then
      echo "Directory '$directory' not found."
      return 1
  fi
  
  docker run -d \
  --name eros \
  --restart no \
  -p 9999:9999 \
  --log-driver json-file \
  --log-opt max-file=10 \
  --log-opt max-size=2m \
  -e STASH_STASH=/data/ \
  -e STASH_GENERATED=/generated/ \
  -e STASH_METADATA=/metadata/ \
  -e STASH_CACHE=/cache/ \
  -e STASH_PORT=9999 \
  -v /etc/localtime:/etc/localtime:ro \
  -v "$EROS_HOME/config":/root/.stash \
  -v "$EROS_HOME/data":/data \
  -v "$EROS_HOME/metadata":/metadata \
  -v "$EROS_HOME/cache":/cache \
  -v "$EROS_HOME/blobs":/blobs \
  -v "$EROS_HOME/generated":/generated \
  stashapp/stash:latest
}
