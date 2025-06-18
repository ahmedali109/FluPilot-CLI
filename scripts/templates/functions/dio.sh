#!/usr/bin/env bash

source ./scripts/templates/helper/create_api_constants.sh
source ./scripts/templates/helper/create_dio_factory.sh
source ./scripts/templates/helper/create_api_error_handler.sh

function dio(){
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
  echo "🛠️ Generating dio template in $DEST_DIR"

  if ! grep -q "dio:" pubspec.yaml; then
    echo "❌ dio not found in pubspec.yaml. Please add it under dependencies."
    echo "Example:"
    echo "dependencies:"
    echo "  dio: latest_version"
    exit 1
  fi

  echo "✅ dio found in pubspec.yaml."
  echo "📂 Creating api_constants.dart in $DEST_DIR/lib/core/networking..."
  echo "📂 Creating dio_factory.dart in $DEST_DIR/lib/core/networking..."
  echo "📂 Creating api_error_handler.dart in $DEST_DIR/lib/core/networking..."

  touch "$DEST_DIR/lib/core/networking/api_constants.dart" || {
    echo "❌ Failed to create api_constants.dart"
    exit 1
  }

  touch "$DEST_DIR/lib/core/networking/dio_factory.dart" || {
    echo "❌ Failed to create dio_factory.dart"
    exit 1
  }

  touch "$DEST_DIR/lib/core/networking/api_error_handler.dart" || {
    echo "❌ Failed to create api_error_handler.dart"
    exit 1
  }

  create_api_constants

  create_dio_factory

  create_api_error_handler

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
