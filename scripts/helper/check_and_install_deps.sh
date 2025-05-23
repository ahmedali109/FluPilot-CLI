#!/bin/bash
set -euo pipefail

function print_and_run_if_deps_installed() {
  for dep in gum flutter python3; do
    echo "✅ $dep is already installed."
  done
  echo "Running main script..."
  source "$SCRIPT_DIR/main.sh"
  exit 0
}

#Available flags
source ./scripts/helper/cli_flags_function.sh

# Get the absolute path to the real script location, resolving symlinks
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")/.." && pwd)"

missing_deps=()

# Detect OS
OS_TYPE="$(uname -s)"

for dep in gum flutter; do
  if ! command -v $dep &>/dev/null; then
    missing_deps+=("$dep")
  fi
done

# Check for python or python3 depending on OS
if [[ "$OS_TYPE" == "Darwin" || "$OS_TYPE" == "Linux" ]]; then
  # macOS or Linux: prefer python3
  if ! command -v python3 &>/dev/null; then
    missing_deps+=("python3")
  fi
elif [[ "$OS_TYPE" == "MINGW"* || "$OS_TYPE" == "CYGWIN"* || "$OS_TYPE" == "MSYS"* ]]; then
  # Windows: prefer python
  if ! command -v python &>/dev/null; then
    missing_deps+=("python")
  fi
else
  # Unknown OS, check for either
  if ! command -v python3 &>/dev/null && ! command -v python &>/dev/null; then
    missing_deps+=("python3" "python")
  fi
fi

if [ ${#missing_deps[@]} -ne 0 ]; then
  echo "❌ The following dependencies are missing: ${missing_deps[*]}"
  read -p "Would you like to install them now? [Y/N]: " answer
  if [[ "$answer" =~ ^[Yy]$ ]]; then
    for dep in "${missing_deps[@]}"; do
      source "$SCRIPT_DIR/setup/install_dependency.sh" "$dep"
    done
    echo "All missing dependencies have been installed."
    print_and_run_if_deps_installed
  else
    echo "Please install the missing dependencies manually and re-run the script."
    echo -e "Missing dependencies:"
    for dep in "${missing_deps[@]}"; do
      echo "$dep"
    done
    echo "Exiting..."
    exit 1
  fi
else
  print_and_run_if_deps_installed
fi
