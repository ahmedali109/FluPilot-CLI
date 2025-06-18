#!/bin/bash

source ./scripts/templates/helper/create_shared_preferences.sh

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

  if ! grep -q "shared_preferences:" pubspec.yaml; then
    echo "❌ shared_preferences not found in pubspec.yaml. Please add it under dependencies."
    echo "Example:"
    echo "dependencies:"
    echo "  shared_preferences: latest_version"
    exit 1
  fi

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
