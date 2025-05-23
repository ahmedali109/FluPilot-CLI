#!/bin/bash

# ------------------ CLI Flags ------------------
function show_help() {
  echo "🛠️  mycli - Flutter Project Starter"
  echo ""
  echo "Usage:"
  echo "  FluPilotCLI [command]"
  echo ""
  echo "Available Commands:"
  echo "  --help, -h       Show this help message"
  echo "  --version, -v    Show CLI version"
}

# Detect --version or --help
case "${1:-}" in
  --version|-v)
    # Read from package.json
    VERSION=$(node -p "require('./package.json').version")
    echo "FluPilot CLI $VERSION"
    exit 0
    ;;
  --help|-h)
    show_help
    exit 0
    ;;
esac
