#!/bin/bash

source ./scripts/templates/helper/custom_slidable.sh

function SlidableFunction(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}"
  if [ -z "$DEST_DIR" ]; then
    echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
    exit 1
  fi
  mkdir -p "$DEST_DIR/lib/core/widgets" || {
    echo "❌ Failed to create directory $DEST_DIR/lib/core/widgets/slidable"
    exit 1
  }
  echo "📂 Created directory $DEST_DIR/lib/core/widgets"
  cd "$DEST_DIR" || exit 1
  echo "🛠️ Generating slidable template in $DEST_DIR"
  if ! grep -q "flutter_slidable:" pubspec.yaml; then
    echo "❌ flutter_slidable not found in pubspec.yaml. Please add it under dependencies."
    echo "Example:"
    echo "dependencies:"
    echo "  flutter_slidable: latest_version"
    exit 1
  fi
  echo "✅ flutter_slidable found in pubspec.yaml."
  echo "📂 Creating custom_slidable.dart in $DEST_DIR/lib/core/widgets..."
  touch "$DEST_DIR/lib/core/widgets/custom_slidable.dart" || {
    echo "❌ Failed to create custom_slidable.dart"
    exit 1
  }

  CustomSlidable

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
