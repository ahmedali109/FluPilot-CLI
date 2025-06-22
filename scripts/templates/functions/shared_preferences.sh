#!/usr/bin/env bash

# Get the absolute path to the real script location, resolving symlinks
# If SCRIPT_DIR is already set (from parent script), use that instead
if [ -z "$SCRIPT_DIR" ]; then
  SOURCE="${BASH_SOURCE[0]}"
  while [ -h "$SOURCE" ]; do
    DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
  done
  SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")/../../.." && pwd)"
fi


source "$SCRIPT_DIR/templates/helper/create_shared_preferences.sh"

function shared_preferences(){
 DEST_DIR="${FLUTTER_PROJECT_DIR}"

  if [ -z "$DEST_DIR" ]; then
    echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
    exit 1
  fi

  mkdir -p "$DEST_DIR/lib/core/helpers" || {
    echo "❌ Failed to create directory $DEST_DIR/lib/core/helpers"
    exit 1
  }

  echo "📂 Created directory $DEST_DIR/lib/core/helpers"
  cd "$DEST_DIR" || exit 1
  echo "🛠️ Generating shared_preferences template in $DEST_DIR"
  echo "📂 Creating shared_pref_helper.dart in $DEST_DIR/lib/core/helpers..."
  touch "$DEST_DIR/lib/core/helpers/shared_pref_helper.dart" || {
    echo "❌ Failed to create shared_pref_helper.dart"
    exit 1
  }

  create_shared_preferences

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
