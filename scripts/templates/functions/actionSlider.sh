#!/usr/bin/env bash

# Get the absolute path to the real script location, resolving symlinks
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")/../../.." && pwd)"


source "$SCRIPT_DIR/templates/helper/create_custom_action_slider.sh

function actionSlider(){
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
  echo "🛠️ Generating action slider template in $DEST_DIR"
  if ! grep -q "action_slider:" pubspec.yaml; then
    echo "❌ action_slider not found in pubspec.yaml. Please add it under dependencies."
    echo "Example:"
    echo "dependencies:"
    echo "  action_slider: latest_version"
    exit 1
  fi
  echo "✅ action_slider found in pubspec.yaml."
  echo "📂 Creating custom_action_slider.dart in $DEST_DIR/lib/core/widgets..."
  touch "$DEST_DIR/lib/core/widgets/custom_action_slider.dart" || {
    echo "❌ Failed to create custom_action_slider.dart"
    exit 1
  }

  create_custom_action_slider

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}

export -f actionSlider
