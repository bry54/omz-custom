# audioflow plugin

This plugin provides tools for scaffolding mbira music projects, downloading YouTube content, and batch-converting media files using ffmpeg.

To use it, add `audioflow` to the plugins array in your zshrc file:

```zsh
plugins=(... audioflow)
```

Requires `ffmpeg` and `docker` to be installed and available on `$PATH`.

---

## Mbira Projects

| Command | Description |
| :--- | :--- |
| `new-mbira-project <name>` | Creates a new mbira project under `~/AudacityProjects/mbira/<name>/` with an `exports/` folder |

---

## YouTube

| Alias | Description |
| :--- | :--- |
| `youtube-downloader <url>` | Downloads YouTube content via Docker (`mikenye/youtube-dl`) into the current directory |

---

## Media Conversion

| Command | Description |
| :--- | :--- |
| `youtube-to-audio <src> <dest>` | Batch converts `.webm`, `.mkv`, `.mp4`, `.mov`, `.avi` to `.mp3` (high quality). Skips already-converted files. Runs `clean-rename` on completion. |
| `youtube-to-video <src> <dest> <mp4\|mkv>` | Batch converts video files to `mp4` (H.264 + AAC) or `mkv` (H.265 + FLAC). Skips already-converted files. Runs `clean-rename` on completion. |
| `clean-rename <dir>` | Recursively strips `[bracketed tags]` from filenames and removes spaces before file extensions |
