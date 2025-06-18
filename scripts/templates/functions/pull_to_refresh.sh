#!/bin/bash
source ./scripts/templates/helper/create_custom_pull_to_refresh.sh
function pullToRefresh(){
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
  echo "🛠️ Generating pull to refresh template in $DEST_DIR"
  if ! grep -q "liquid_pull_to_refresh:" pubspec.yaml; then
    echo "❌ liquid_pull_to_refresh not found in pubspec.yaml. Please add it under dependencies."
    echo "Example:"
    echo "dependencies:"
    echo "  liquid_pull_to_refresh: latest_version"
    exit 1
  fi
  echo "✅ liquid_pull_to_refresh found in pubspec.yaml."
  echo "📂 Creating custom_pull_to_refresh.dart in $DEST_DIR/lib/core/widgets..."
  touch "$DEST_DIR/lib/core/widgets/custom_pull_to_refresh.dart" || {
    echo "❌ Failed to create custom_pull_to_refresh.dart"
    exit 1
  }

  create_custom_pull_to_refresh

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
