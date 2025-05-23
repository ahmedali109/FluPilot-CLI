#!/bin/bash
set -euo pipefail

# Get the absolute path to the real script location, resolving symlinks
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")/.." && pwd)"

missing_deps=()
for dep in gum python3; do
  if ! command -v $dep &>/dev/null; then
    missing_deps+=("$dep")
  fi
done

if [ ${#missing_deps[@]} -ne 0 ]; then
  echo "❌ The following dependencies are missing: ${missing_deps[*]}"
  read -p "Would you like to install them now? [y/N]: " answer
  if [[ "$answer" =~ ^[Yy]$ ]]; then
    for dep in "${missing_deps[@]}"; do
      source "$SCRIPT_DIR/scripts/install_dependency.sh" "$dep"
    done
  else
    echo "Please install the missing dependencies and re-run the script."
    echo -e "Missing dependencies:\n"
    for dep in "${missing_deps[@]}"; do
      echo " - $dep"
    done
    echo "Exiting..."
    exit 1
  fi
fi
