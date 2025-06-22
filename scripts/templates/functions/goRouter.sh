#!/usr/bin/env bash

# Get the absolute path to the real script location, resolving symlinks
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")/../../.." && pwd)"


source "$SCRIPT_DIR/templates/helper/create_go_router.sh"

function goRouter(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}"
  if [ -z "$DEST_DIR" ]; then
    echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
    exit 1
  fi
  mkdir -p "$DEST_DIR/lib/core/router" || {
    echo "❌ Failed to create directory $DEST_DIR/lib/core/router"
    exit 1
  }
  echo "📂 Created directory $DEST_DIR/lib/core/router"
  cd "$DEST_DIR" || exit 1
  echo "🛠️ Generating go_router template in $DEST_DIR"
  echo "✅ go_router found in pubspec.yaml."
  echo "📂 Creating go_router.dart in $DEST_DIR/lib/core/router..."

  touch "$DEST_DIR/lib/core/router/go_router.dart" || {
    echo "❌ Failed to create go_router.dart"
    exit 1
  }
  touch "$DEST_DIR/lib/core/router/wrapper.dart" || {
    echo "❌ Failed to create wrapper.dart"
    exit 1
  }

  create_go_router

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
