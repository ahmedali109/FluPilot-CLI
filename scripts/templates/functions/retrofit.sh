#!/bin/bash

source ./scripts/templates/helper/create_api_service.sh

function retrofit() {
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
  echo "🛠️ Generating retrofit template in $DEST_DIR"

  if ! grep -q "retrofit:" pubspec.yaml; then
    echo "❌ retrofit not found in pubspec.yaml. Please add it under dependencies."
    echo "Example:"
    echo "dependencies:"
    echo "  retrofit: latest_version"
    exit 1
  fi

  echo "📂 Creating api_service.dart in $DEST_DIR/lib/core/networking..."

  touch "$DEST_DIR/lib/core/networking/api_service.dart" || {
    echo "❌ Failed to create api_service.dart"
    exit 1
  }

  create_api_service

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}

export -f retrofit
