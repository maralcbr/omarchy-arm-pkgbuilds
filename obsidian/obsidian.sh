#!/bin/bash

OBSIDIAN_USER_FLAGS_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/obsidian/user-flags.conf"

case "${1:-}" in
  --version|-V)
    echo "obsidian 1.13.7"
    exit 0
    ;;
  --help|-h)
    echo "Usage: obsidian [options] [paths...]"
    exit 0
    ;;
esac

if [[ -f "${OBSIDIAN_USER_FLAGS_FILE}" ]]; then
  mapfile -t OBSIDIAN_USER_FLAGS < <(grep -Ev '^\s*(#|$)' "${OBSIDIAN_USER_FLAGS_FILE}")
fi

exec /usr/lib/obsidian/obsidian --ozone-platform-hint=auto "${OBSIDIAN_USER_FLAGS[@]}" "$@"
