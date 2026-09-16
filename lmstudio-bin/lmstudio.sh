#!/bin/bash

case "${1:-}" in
  --version|-V)
    echo "lm-studio 0.4.24"
    exit 0
    ;;
  --help|-h)
    echo "Usage: lm-studio [options]"
    exit 0
    ;;
esac

exec /usr/lib/lmstudio/lm-studio.AppImage "$@"
