#!/bin/bash

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

OBSIDIAN_USER_FLAGS=()
if [[ -f "${XDG_CONFIG_HOME}/obsidian-flags.conf" ]]; then
    mapfile -t OBSIDIAN_USER_FLAGS < <(grep -Ev '^\s*#|^\s*$' "${XDG_CONFIG_HOME}/obsidian-flags.conf")
fi

# Worker/containers often have no FUSE; the AppImage still runs extracted.
export APPIMAGE_EXTRACT_AND_RUN=1
exec /opt/obsidian/obsidian.AppImage "${OBSIDIAN_USER_FLAGS[@]}" "$@"
