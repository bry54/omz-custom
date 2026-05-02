alias yt-dl='docker run \
    --rm -i \
    -e PGID=$(id -g) \
    -e PUID=$(id -u) \
    -v "$(pwd)":/workdir:rw \
    mikenye/youtube-dl'

trim-media() {
    local infile="$1"
    local start="$2"
    local end="$3"

    if [[ -z "$infile" ]] || [[ -z "$start" ]]; then
        echo "Usage: trimvid <file> <start> [end]"
        echo "Example with end:    trimvid video.mp4 00:01:00 00:02:00"
        echo "Example to file end: trimvid video.mp4 00:01:00"
        return 1
    fi

    if [[ ! -f "$infile" ]]; then
        echo "File not found: $infile"
        return 1
    fi

    local base="${infile%.*}"
    local ext="${infile##*.}"
    local counter=1
    local curr_in="$infile"

    while true; do
        local outfile="${base}_trimmed.$ext"

        echo "Trimming '$curr_in' from $start ${end:+to $end}..."

        if [[ -z "$end" ]]; then
            ffmpeg -y -i "$curr_in" -ss "$start" -c copy "$outfile"
        else
            ffmpeg -y -i "$curr_in" -ss "$start" -to "$end" -c copy "$outfile"
        fi

        if [[ $? -ne 0 ]]; then
            echo "ffmpeg failed."
            return 1
        fi

        echo "Trim completed: $outfile"
        echo -n "Are you done with '$infile'? [y/N]: "
        read answer

        if [[ "$answer" =~ ^[Yy]$ ]]; then
            echo "Finalizing..."
            rm "$infile"
            mv "$outfile" "$infile"
            echo "Replaced original file with trimmed version."
            return 0
        fi

        # Not done → save part
        local part_out="${base}_p${counter}.$ext"
        mv "$outfile" "$part_out"
        echo "Saved chunk: $part_out"
        ((counter++))

        # Single prompt for next start/end
        while true; do
            echo -n "Enter next [start end] (end optional): "
            read -r input

            # split to array
            local parts=($input)

            if (( ${#parts[@]} == 1 )); then
                start="${parts[0]}"
                end=""
                break
            elif (( ${#parts[@]} == 2 )); then
                start="${parts[0]}"
                end="${parts[1]}"
                break
            else
                echo "Invalid. Enter one or two values."
            fi
        done
    done
}
