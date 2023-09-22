function getcontentlength() {
  # Check if a URL is provided as an argument
  if [ $# -ne 1 ]; then
      echo "Usage: getcontentlength <URL>"
      return 1
  fi

  local URL="$1"

  # Extract the file name from the URL and use it as the default
  local default_filename
  default_filename=$(basename "$URL")

  # Use curl to fetch the headers and extract the content length
  local content_length
  content_length=$(curl -I "$URL" 2>/dev/null | grep -i "Content-Length" | awk '{print $2}')

  # Check if content_length is empty (URL not found or other error)
  if [ -z "$content_length" ]; then
      echo "Failed to retrieve content length from $URL"
      return 1
  fi

  # Convert the content length from bytes to megabytes
  local content_length_mb
  content_length_mb=$(echo "scale=2; $content_length / (1024 * 1024)" | bc)

  echo "Content Length: $content_length_mb MB"

  # Prompt the user if they want to download the file
  echo -n "Do you want to download the file (y/n)? "
  read choice
  if [ "$choice" = "y" ]; then
      # Prompt the user for a directory to save the file in
      echo -n "Enter the directory path to save the file (or press Enter for current directory): "
      read dir_path
      if [ -z "$dir_path" ]; then
          dir_path="./"  # Default to the current directory
      fi

      # Prompt the user for a file name to save with, or use the default name
      echo -n "Enter a file name (or press Enter for default: $default_filename): "
      read filename
      if [ -z "$filename" ]; then
          filename="$default_filename"
      fi

      # Combine the directory path and file name
      file_path="${dir_path%/}/$filename"

      echo "Downloading $URL to $file_path..."
      # Use curl to download the file with the specified path and name
      curl -o "$file_path" "$URL"
      echo "Download completed. Saved as: $file_path"
  else
      echo "Download canceled."
  fi
}

function bulkextensiontransformer(){
    # Get the parent directory, old extension, and new extension from the arguments
    parent_dir="$1"
    old_ext="$2"
    new_ext="$3"

    # Check if the parent directory exists
    if [ ! -d "$parent_dir" ]; then
        echo "Parent directory not found: $parent_dir"
        exit 1
    fi

    # Iterate through each old file in subdirectories
    find "$parent_dir" -type f -name "*.$old_ext" -print0 | while IFS= read -r -d '' file; do
        new_name="${file%.$old_ext}"
        echo "Renaming $file to $new_name.$new_ext"
        mv "$file" "$new_name.$new_ext"
    done

    echo "Extension removal completed."

    # Iterate through each file in subdirectories
    find "$parent_dir" -type f ! -name "*.*" -print0 | while IFS= read -r -d '' file; do
        new_name="$file.$new_ext"
        echo "Renaming $file to $new_name"
        mv "$file" "$new_name"
    done

    echo "Renaming completed."
}
