#!/bin/bash
# Official Spotify Desktop is x86_64-only. Open the web player instead.

url='https://open.spotify.com'

for arg in "$@"; do
  case "$arg" in
    --uri=https://*|--uri=http://*)
      url="${arg#--uri=}"
      ;;
    --uri=spotify:*)
      path="${arg#--uri=spotify:}"
      url="https://open.spotify.com/${path//://}"
      ;;
    spotify:*)
      path="${arg#spotify:}"
      url="https://open.spotify.com/${path//://}"
      ;;
  esac
done

for bin in chromium google-chrome-stable google-chrome firefox; do
  if command -v "$bin" >/dev/null 2>&1; then
    exec "$bin" --ozone-platform-hint=auto --app="$url"
  fi
done

echo 'spotify: install chromium, google-chrome, or firefox to use the web player' >&2
exit 1
