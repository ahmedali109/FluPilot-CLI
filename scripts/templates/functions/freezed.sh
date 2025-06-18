#!/usr/bin/env bash

source ./scripts/templates/helper/create_api_result.sh

function freezed(){
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
  echo "🛠️ Generating freezed template in $DEST_DIR"

  if ! grep -q "freezed:" pubspec.yaml; then
    echo "❌ freezed not found in pubspec.yaml. Please add it under dependencies."
    echo "Example:"
    echo "dependencies:"
    echo "  freezed: latest_version"
    exit 1
  fi

  echo "📂 Creating api_result.dart in $DEST_DIR/lib/core/networking..."
  touch "$DEST_DIR/lib/core/networking/api_result.dart" || {
    echo "❌ Failed to create api_result.dart"
    exit 1
  }

  create_api_result

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
