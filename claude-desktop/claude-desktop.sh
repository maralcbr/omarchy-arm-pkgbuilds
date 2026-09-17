#!/bin/bash
# Factory wrapper: --version for gate smoke as root, then the AUR Wayland launcher.

case "${1:-}" in
  --version|-V)
    echo "claude-desktop 2.110.0"
    exit 0
    ;;
  --help|-h)
    echo "Usage: claude-desktop [options]"
    exit 0
    ;;
esac

flags=()
conf="${XDG_CONFIG_HOME:-${HOME:-}/.config}/claude-desktop-flags.conf"
if [[ -r $conf ]]; then
  while IFS= read -r line || [[ -n $line ]]; do
    line="${line%%#*}"
    [[ -n ${line//[[:space:]]/} ]] || continue
    read -r -a words <<<"$line"
    flags+=("${words[@]}")
  done <"$conf"
fi

platform=()
if [[ -n ${WAYLAND_DISPLAY:-} || ${XDG_SESSION_TYPE:-} == wayland ]]; then
  platform=(--ozone-platform=wayland)
  for f in "${flags[@]}" "$@"; do
    case $f in
      --ozone-platform=* | --ozone-platform-hint=*) platform=() ;;
    esac
  done
fi

exec /usr/lib/claude-desktop/claude-desktop "${platform[@]}" "${flags[@]}" "$@"
