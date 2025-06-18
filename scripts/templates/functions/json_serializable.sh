#!/usr/bin/env bash

# Get the absolute path to the real script location, resolving symlinks
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")/../../.." && pwd)"


source "$SCRIPT_DIR/templates/helper/create_api_error_model.sh

function json_serializable(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}"

  if [ -z "$DEST_DIR" ]; then
    echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
    exit 1
  fi

  mkdir -p "$DEST_DIR/lib/core/networking" || {
    echo "❌ Failed to create directory $DEST_DIR/lib/core/networking"
    exit 1
  }

  echo "📂 Created directory $DEST_DIR/lib/core/networking"
  cd "$DEST_DIR" || exit 1
  echo "🛠️ Generating json_serializable template in $DEST_DIR"

  if ! grep -q "json_serializable:" pubspec.yaml; then
    echo "❌ json_serializable not found in pubspec.yaml. Please add it under dependencies."
    echo "Example:"
    echo "dependencies:"
    echo "  json_serializable: latest_version"
    exit 1
  fi

  echo "📂 Creating api_error_model.dart in $DEST_DIR/lib/core/networking..."

  touch "$DEST_DIR/lib/core/networking/api_error_model.dart" || {
    echo "❌ Failed to create api_error_model.dart"
    exit 1
  }

  create_api_error_model

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
