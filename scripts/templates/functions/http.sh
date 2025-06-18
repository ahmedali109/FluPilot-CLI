#!/bin/bash

source ./scripts/templates/helper/create_http_service.sh

function http(){
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
  echo "🛠️ Generating http template in $DEST_DIR"
  if ! grep -q "http:" pubspec.yaml; then
    echo "❌ http not found in pubspec.yaml. Please add it under dependencies."
    echo "Example:"
    echo "dependencies:"
    echo "  http: latest_version"
    exit 1
  fi
  echo "✅ http found in pubspec.yaml."
  echo "📂 Creating http_service.dart in $DEST_DIR/lib/core/networking..."

  touch "$DEST_DIR/lib/core/networking/http_service.dart" || {
    echo "❌ Failed to create http_service.dart"
    exit 1
  }

  create_http_service

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
