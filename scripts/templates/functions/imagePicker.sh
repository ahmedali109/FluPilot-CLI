#!/bin/bash

source ./scripts/templates/helper/create_image_picker.sh
source ./scripts/templates/permission/ios/image_picker_permission.sh

function imagePicker(){
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
  echo "🛠️ Generating image picker template in $DEST_DIR"
  if ! grep -q "image_picker:" pubspec.yaml; then
    echo "❌ image_picker not found in pubspec.yaml. Please add it under dependencies."
    echo "Example:"
    echo "dependencies:"
    echo "  image_picker: latest_version"
    exit 1
  fi
  echo "✅ image_picker found in pubspec.yaml."
  echo "📂 Creating image_picker.dart in $DEST_DIR/lib/core/widgets..."
  touch "$DEST_DIR/lib/core/widgets/image_picker.dart" || {
    echo "❌ Failed to create image_picker.dart"
    exit 1
  }

  create_image_picker

  echo "📄 Configured Permission in Info.plist."
  add_image_picker_ios_permission
  echo "✅ Permissions added to Info.plist."

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
