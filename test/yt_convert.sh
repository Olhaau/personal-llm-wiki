#!/bin/bash
set -e

# Usage: t_convert <youtube-playlist-or-video-url> [artist] [album]

YT_LINK="$1"
USER_ARTIST="$2"
USER_ALBUM="$3"

if [ -z "$YT_LINK" ]; then
    echo "Usage: $0 <youtube-playlist-or-video-url> [artist] [album]"
    exit 1
fi

# Get playlist title or video title if no playlist
playlist_title=$(yt-dlp --flat-playlist --skip-download --print "%(playlist_title)s" "$YT_LINK" 2>/dev/null | head -n1)
if [ -z "$playlist_title" ]; then
    playlist_title=$(yt-dlp --skip-download --print "%(title)s" "$YT_LINK" 2>/dev/null | head -n1)
fi

# Sanitize playlist title (allow alnum, dash, underscore, dot, space; trim trailing space/underscores/dashes)
safe_playlist_title=$(echo "$playlist_title" | tr -cd '[:alnum:]._ -' | sed 's/[ _-]*$//')

# Determine album to use
if [ -n "$USER_ALBUM" ]; then
    album_to_use="$USER_ALBUM"
else
    album_to_use="$playlist_title"
fi

# Determine artist to use:
artist_to_use=""

if [ -n "$USER_ARTIST" ]; then
    artist_to_use="$USER_ARTIST"
else
    echo "Guessing unique artist from playlist..."

    # Collect artist tags from JSON (try 'artist' tag)
    artists=$(yt-dlp --flat-playlist --dump-json "$YT_LINK" 2>/dev/null | jq -r '.artist? // empty' | sort -u)

    # If empty, try uploader names
    if [ -z "$artists" ]; then
        artists=$(yt-dlp --flat-playlist --dump-json "$YT_LINK" 2>/dev/null | jq -r '.uploader // empty' | sort -u)
    fi

    artist_count=$(echo "$artists" | grep -cv '^$')

    if [ "$artist_count" -eq 1 ]; then
        artist_to_use="$artists"
        echo "Unique artist found: $artist_to_use"
    else
        echo "Multiple or no unique artists found, not setting Album Artist."
    fi
fi

# Sanitize artist folder name (replace spaces and slashes etc with underscore, then trim trailing underscores/dashes/spaces)
#BASE_MUSIC_DIR="$HOME/music"
BASE_MUSIC_DIR="/mnt/data/data/media/music"

if [ -n "$artist_to_use" ]; then
    artist_folder=$(echo "$artist_to_use" | tr ' /' '__' | sed 's/[ _-]*$//')
    target_dir="${BASE_MUSIC_DIR}/${artist_folder}/${safe_playlist_title}"
else
    target_dir="${BASE_MUSIC_DIR}/${safe_playlist_title}"
fi

mkdir -p "$target_dir"
cd "$target_dir"

echo "Downloading and converting into: $PWD"

# Always download fresh
#yt-dlp -f bestaudio --embed-metadata --write-thumbnail -o "%(playlist_index)s-%(title)s.%(ext)s" "$YT_LINK"

# Check if any .webm exist to skip download - you can remove this if you want always download
if ls *.webm 1> /dev/null 2>&1; then
    echo "Found existing .webm files. Skipping download."
else
    yt-dlp -f bestaudio --embed-metadata --write-thumbnail -o "%(playlist_index)s-%(title)s.%(ext)s" "$YT_LINK"
fi

# Find thumbnail with supported extensions
thumb=""
for ext in jpg jpeg png webp; do
    thumbfile=$(ls *."$ext" 2>/dev/null | head -n1)
    if [ -n "$thumbfile" ]; then
        thumb="$thumbfile"
        break
    fi
done

if [ -n "$thumb" ]; then
    thumb_jpg="thumbnail.jpg"
    # Correct the condition below to properly check if thumb is NOT jpg/jpeg
    if [[ "$thumb" != *.jpg && "$thumb" != *.jpeg ]]; then
        echo "Converting thumbnail $thumb to JPEG format..."
        ffmpeg -y -i "$thumb" -qscale:v 2 "$thumb_jpg"
    else
        thumb_jpg="$thumb"
    fi
else
    echo "No thumbnail found, continuing without cover art."
fi

# Convert .webm to mp3 embedding track number, album artist and cover image
for f in *.webm; do
    tracknum="${f%%-*}"
    base="${f%.webm}"
    outfile="${base}.mp3"

    if [ -n "$thumb_jpg" ]; then
        if [ -n "$artist_to_use" ]; then
            ffmpeg -y -i "$f" -i "$thumb_jpg" \
                -map 0:a -map 1:v \
                -metadata track="$tracknum" \
                -metadata album="$album_to_use" \
                -metadata album_artist="$artist_to_use" \
                -metadata:s:v title="Album cover" -metadata:s:v comment="Cover (front)" \
                -id3v2_version 3 \
                -codec:a libmp3lame -q:a 2 \
                "$outfile"
        else
            ffmpeg -y -i "$f" -i "$thumb_jpg" \
                -map 0:a -map 1:v \
                -metadata track="$tracknum" \
                -metadata album="$album_to_use" \
                -metadata:s:v title="Album cover" -metadata:s:v comment="Cover (front)" \
                -id3v2_version 3 \
                -codec:a libmp3lame -q:a 2 \
                "$outfile"
        fi
    else
        if [ -n "$artist_to_use" ]; then
            ffmpeg -y -i "$f" \
                -metadata track="$tracknum" \
                -metadata album="$album_to_use" \
                -metadata album_artist="$artist_to_use" \
                -id3v2_version 3 \
                -codec:a libmp3lame -q:a 2 \
                "$outfile"
        else
            ffmpeg -y -i "$f" \
                -metadata track="$tracknum" \
                -metadata album="$album_to_use" \
                -id3v2_version 3 \
                -codec:a libmp3lame -q:a 2 \
                "$outfile"
        fi
    fi

    if [ $? -eq 0 ]; then
        echo "Converted $f → $outfile successfully."
        rm "$f"
    else
        echo "Conversion failed for $f. Original file not removed."
    fi
done

# Clean up thumbnails
if [ -n "$thumb_jpg" ] && [ "$thumb_jpg" != "$thumb" ]; then
    rm "$thumb_jpg"
fi
if [ -n "$thumb" ]; then
    rm "$thumb"
fi

# Remove leftover .webm and .webp files if any
rm -f *.webp 2>/dev/null || true
rm -f *.webm 2>/dev/null || true

# copy, set ownership and remove in HOME dir
#if cp -a ~/music/. /mnt/data/data/media/music/; then
#    # Only remove ~/music if both commands succeed
#    rm -rf "${BASE_MUSIC_DIR}/${artist_folder}"
#else
#    echo "Copy or chown failed; ~/music was NOT removed."
#fi

echo "Done!"
