#!/bin/bash

source ./scripts/templates/helper/create_video_player_service.sh
source ./scripts/templates/permission/android/video_player_permission.sh

function videoPlayers(){
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
  echo "🛠️ Generating video player template in $DEST_DIR"
  if ! grep -q "video_player:" pubspec.yaml; then
    echo "❌ video_player not found in pubspec.yaml. Please add it under dependencies."
    echo "Example:"
    echo "dependencies:"
    echo "  video_player: latest_version"
    exit 1
  fi
  echo "✅ video_player found in pubspec.yaml."
  echo "📂 Creating video_player_service.dart in $DEST_DIR/lib/core/widgets..."
  touch "$DEST_DIR/lib/core/widgets/video_player_service.dart" || {
    echo "❌ Failed to create video_player_service.dart"
    exit 1
  }

  create_video_player_service

  echo "📄 Configured Permission in AndroidManifest.xml."
  add_video_player_service_Android_permission
  echo "✅ Permissions added to AndroidManifest.xml."

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
