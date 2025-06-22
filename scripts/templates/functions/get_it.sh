#!/usr/bin/env bash

# Get the absolute path to the real script location, resolving symlinks
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")/../../.." && pwd)"


source "$SCRIPT_DIR/templates/helper/create_dependency_injection.sh"

function get_it(){
 DEST_DIR="${FLUTTER_PROJECT_DIR}"

  if [ -z "$DEST_DIR" ]; then
    echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
    exit 1
  fi

  mkdir -p "$DEST_DIR/lib/core/di" || {
    echo "❌ Failed to create directory $DEST_DIR/lib/core/di"
    exit 1
  }

  echo "📂 Created directory $DEST_DIR/lib/core/di"
  cd "$DEST_DIR" || exit 1
  echo "🛠️ Generating get_it template in $DEST_DIR"
  echo "📂 Creating dependency_injection.dart in $DEST_DIR/lib/core/di..."
  touch "$DEST_DIR/lib/core/di/dependency_injection.dart" || {
    echo "❌ Failed to create dependency_injection.dart"
    exit 1
  }

  create_dependency_injection

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
