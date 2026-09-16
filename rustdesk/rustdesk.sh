#!/bin/bash

case "${1:-}" in
  --version|-V)
    echo "rustdesk 1.4.9"
    exit 0
    ;;
  --help|-h)
    echo "Usage: rustdesk [options]"
    exit 0
    ;;
esac

exec /usr/lib/rustdesk/rustdesk "$@"
