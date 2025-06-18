#!/bin/bash

source ./scripts/templates/helper/create_cloud_firestore.sh

function cloud_firestore(){
 DEST_DIR="${FLUTTER_PROJECT_DIR}"

  if [ -z "$DEST_DIR" ]; then
    echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
    exit 1
  fi

  mkdir -p "$DEST_DIR/lib/core/services" || {
    echo "❌ Failed to create directory $DEST_DIR/lib/core/services"
    exit 1
  }

  echo "📂 Created directory $DEST_DIR/lib/core/services"
  cd "$DEST_DIR" || exit 1
  echo "🛠️ Generating cloud_firestore template in $DEST_DIR"

  if ! grep -q "cloud_firestore:" pubspec.yaml; then
    echo "❌ cloud_firestore not found in pubspec.yaml. Please add it under dependencies."
    echo "Example:"
    echo "dependencies:"
    echo "  cloud_firestore: latest_version"
    exit 1
  fi

  echo "📂 Creating firestore_service.dart in $DEST_DIR/lib/core/services..."

  touch "$DEST_DIR/lib/core/services/firestore_service.dart" || {
    echo "❌ Failed to create firestore_service.dart"
    exit 1
  }

  create_cloud_firestore

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
