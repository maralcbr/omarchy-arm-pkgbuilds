#!/bin/bash

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

case "${1:-}" in
  --version|-V)
    echo "bitwarden 2026.8.0"
    exit 0
    ;;
  --help|-h)
    echo "Usage: bitwarden [options]"
    exit 0
    ;;
esac

if [[ -f "$XDG_CONFIG_HOME/bitwarden-flags.conf" ]]; then
  mapfile -t BITWARDEN_USER_FLAGS < <(grep -Ev '^\s*(#|$)' "$XDG_CONFIG_HOME/bitwarden-flags.conf")
fi

export ELECTRON_IS_DEV=0
exec /usr/lib/bitwarden/bitwarden "${BITWARDEN_USER_FLAGS[@]}" "$@"
