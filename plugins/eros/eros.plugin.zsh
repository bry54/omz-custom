# Function to generate random MD5 string
md5string() {
    #echo -n "$(date +%s%N)$RANDOM" | md5
    cat /dev/urandom | LC_CTYPE=C tr -dc 'a-f0-9' | head -c 32 | md5
}

erosbulkrename(){
    # Source directory containing files to be renamed
    source_directory="$1"

    # Destination directory to save renamed files
    dest_directory="$2"

    # Log file to store renaming details
    log_file=".eroslog.txt"

    # Check if the source directory exists
    if [ ! -d "$source_directory" ]; then
        echo "Source directory '$source_directory' not found."
        return 1
    fi

    # Check if the destination directory exists, create if it does not
    if [ ! -d "$dest_directory" ]; then
        mkdir -p "$dest_directory"
    fi

    # Iterate over each file in the source directory and its subdirectories
    find "$source_directory" -type f -print0 | while IFS= read -r -d '' file; do
        # Get the file extension
        extension="${file##*.}"

        # Check if the file extension is 'eros'
        if [ "$extension" = "eros" ]; then
            # Generate a random MD5 string
            random_md5=$(md5string)

            # Extract the parent directory and the old file name
            parent_dir=$(basename "$(dirname "$file")")
            old_name=$(basename "$file")
            new_name="$random_md5.$extension"

            # New file path in the destination directory
            new_file="$dest_directory/$new_name"

            # Copy and rename the file to the destination directory
            mv "$file" "$new_file"

            # Print the old and new file names to the log file
            echo "$new_name -> $parent_dir/$old_name" >> "$log_file"
        fi
    done

    echo "All '.eros' files renamed and copied successfully. Log appended to '$log_file'."
}

erosserve(){
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

# Function to generate random MD5 string
eroszip() {
  zip -0 -r "$1" "$2"
}

eroscollect(){
  source="$1"
  destination="$2"
  extenstions=("vid" "mp4")

  # Check if the directory exists
  if [ ! -d "$source" ]; then
      echo "Source Directory '$source' not found."
      return 1
  fi

  # Check if the directory exists
  if [ ! -d "$destination" ]; then
      echo "Destination Directory '$destination' not found."
      return 1
  fi

  # Loop through each element in the array
  for ext in "${extenstions[@]}"; do
    echo "$source" "$ext" "eros"
    bulkextensiontransformer "$source" "$ext" "eros"
  done

  erosbulkrename "${source}" "${destination}"

  find "$base_directory" -type d -empty -exec rmdir {} +
  echo "Empty folders cleaned up."
}

erosmockup(){
  # Base directory where folders will be created
  base_directory="$1"

  # Create the base directory if it doesn't exist
  mkdir -p "$base_directory"

  # Loop to create 5 folders
  for i in {1..5}; do
      # Folder name
      folder="$base_directory/folder$i"

      # Create the folder
      mkdir -p "$folder"

      # Loop to create 3 files in each folder
      for j in {1..3}; do
          # File name
          file="$folder/file$j.eros"

          # Create the file
          touch "$file"
      done
  done

  echo "5 folders with 3 files each created successfully in $base_directory."
}
