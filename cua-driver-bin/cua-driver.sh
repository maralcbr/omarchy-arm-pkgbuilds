#!/bin/bash

case "${1:-}" in
  --version|-V)
    echo "cua-driver 0.28.2"
    exit 0
    ;;
  --help|-h)
    echo "Usage: cua-driver [command]"
    exit 0
    ;;
esac

exec /usr/lib/cua-driver/cua-driver "$@"
