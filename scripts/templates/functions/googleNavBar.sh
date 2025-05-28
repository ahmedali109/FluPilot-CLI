#!/bin/bash

source ./scripts/templates/helper/create_google_nav_bar.sh

function googleNavBar(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}"
  if [ -z "$DEST_DIR" ]; then
    echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
    exit 1
  fi
  mkdir -p "$DEST_DIR/lib/core/widgets" || {
    echo "❌ Failed to create directory $DEST_DIR/lib/core/widgets"
    exit 1
  }
  echo "📂 Created directory $DEST_DIR/lib/core/widgets"
  cd "$DEST_DIR" || exit 1
  echo "🛠️ Generating google nav bar template in $DEST_DIR"
  if ! grep -q "google_nav_bar:" pubspec.yaml; then
    echo "❌ google_nav_bar not found in pubspec.yaml. Please add it under dependencies."
    echo "Example:"
    echo "dependencies:"
    echo "  google_nav_bar: latest_version"
    exit 1
  fi
  echo "✅ google_nav_bar found in pubspec.yaml."
  echo "📂 Creating google_navbar.dart in $DEST_DIR/lib/core/widgets..."
  touch "$DEST_DIR/lib/core/widgets/google_navbar.dart" || {
    echo "❌ Failed to create google_navbar.dart"
    exit 1
  }

  create_google_nav_bar

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
