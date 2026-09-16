#!/bin/bash

case "${1:-}" in
  --version|-V)
    echo "cursor 3.20.21"
    exit 0
    ;;
  --help|-h)
    echo "Usage: cursor [options] [paths...]"
    exit 0
    ;;
esac

exec /usr/lib/cursor/cursor "$@"
