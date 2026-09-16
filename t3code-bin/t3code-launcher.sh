#!/bin/bash
set -euo pipefail

case "${1:-}" in
  --version|-V)
    echo "t3code 0.0.42"
    exit 0
    ;;
  --help|-h)
    echo "Usage: t3code [options] [paths...]"
    exit 0
    ;;
esac

user_flags=()
config_home="${XDG_CONFIG_HOME:-}"
[[ -n "$config_home" || -z "${HOME:-}" ]] || config_home="$HOME/.config"
flags_file="${config_home:+$config_home/t3code-flags.conf}"

if [[ -n "$flags_file" && -f "$flags_file" && -r "$flags_file" ]]; then
  while IFS= read -r line || [[ -n "$line" ]]; do
    line="${line%%#*}"
    [[ -n "${line//[[:space:]]/}" ]] || continue
    read -r -a flags <<<"$line"
    user_flags+=("${flags[@]}")
  done <"$flags_file"
fi

# Chromium's own Ozone detection falls back to XWayland often enough to matter,
# and the result is a blurry window on every scaled display.
platform_flags=()
if [[ -n "${WAYLAND_DISPLAY:-}" || "${XDG_SESSION_TYPE:-}" == wayland ]]; then
  platform_flags=(--ozone-platform=wayland)

  for flag in "${user_flags[@]}" "$@"; do
    case "$flag" in
      --ozone-platform=* | --ozone-platform-hint=*) platform_flags=() ;;
    esac
  done
fi

exec /usr/lib/t3code/t3code "${platform_flags[@]}" "${user_flags[@]}" "$@"
