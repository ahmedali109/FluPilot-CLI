#!/bin/bash

source ./scripts/templates/helper/create_audio_player_service.sh
source ./scripts/templates/permission/android/audio_player_permission.sh

function audioPlayers(){
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
  echo "🛠️ Generating audio players template in $DEST_DIR"
  if ! grep -q "audioplayers:" pubspec.yaml; then
    echo "❌ audioplayers not found in pubspec.yaml. Please add it under dependencies."
    echo "Example:"
    echo "dependencies:"
    echo "  audioplayers: latest_version"
    exit 1
  fi
  echo "✅ audioplayers found in pubspec.yaml."
  echo "📂 Creating audio_player_service.dart in $DEST_DIR/lib/core/widgets..."
  touch "$DEST_DIR/lib/core/widgets/audio_player_service.dart" || {
    echo "❌ Failed to create audio_player_service.dart"
    exit 1
  }

  create_audio_player_service

  echo "📄 Configured Permission in AndroidManifest.xml."
  add_audio_player_service_Android_permission
  echo "✅ Permissions added to AndroidManifest.xml."

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
