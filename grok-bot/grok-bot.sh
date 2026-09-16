#!/bin/bash

case "${1:-}" in
  --version|-V)
    echo "grok-bot 0.29.0"
    exit 0
    ;;
  --help|-h)
    echo "Usage: grok-bot [options]"
    exit 0
    ;;
esac

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}

export ELECTRON_OZONE_PLATFORM_HINT="${ELECTRON_OZONE_PLATFORM_HINT:-wayland}"
export NIXOS_OZONE_WL="${NIXOS_OZONE_WL:-1}"

if [[ -f $XDG_CONFIG_HOME/grok-bot-flags.conf ]]; then
  GROK_BOT_USER_FLAGS="$(sed 's/#.*//' "$XDG_CONFIG_HOME/grok-bot-flags.conf" | tr '\n' ' ')"
fi

if [[ -x /usr/lib/grok-bot/grok-bot ]]; then
  GROK_BOT_BIN=/usr/lib/grok-bot/grok-bot
else
  GROK_BOT_BIN=/usr/lib/grok-bot/sand
fi

exec "$GROK_BOT_BIN" \
  --ozone-platform=wayland \
  --enable-features=UseOzonePlatform,WaylandWindowDecorations \
  --enable-wayland-ime \
  "$@" $GROK_BOT_USER_FLAGS
