#!/bin/bash

source ./scripts/templates/helper/create_cached_network_image.sh

function cached_network_image(){
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
  echo "🛠️ Generating cached_network_image template in $DEST_DIR"

  if ! grep -q "cached_network_image:" pubspec.yaml; then
    echo "❌ cached_network_image not found in pubspec.yaml. Please add it under dependencies."
    echo "Example:"
    echo "dependencies:"
    echo "  cached_network_image: latest_version"
    exit 1
  fi

  echo "📂 Creating cached_image.dart in $DEST_DIR/lib/core/helpers..."

  touch "$DEST_DIR/lib/core/helpers/cached_image.dart" || {
    echo "❌ Failed to create cached_image.dart"
    exit 1
  }

  create_cached_network_image

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
