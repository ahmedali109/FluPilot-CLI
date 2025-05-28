#!/bin/bash

function add_audio_player_service_Android_permission(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}"
  MANIFEST_FILE="$DEST_DIR/android/app/src/main/AndroidManifest.xml"
  if [ -z "$DEST_DIR" ]; then
    echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
    exit 1
  fi
  if [ ! -f "$MANIFEST_FILE" ]; then
    echo "❌ AndroidManifest.xml not found at $MANIFEST_FILE."
    exit 1
  fi
  if grep -q '<uses-permission android:name="android.permission.INTERNET"' "$MANIFEST_FILE"; then
    echo "ℹ️ INTERNET permission already exists in AndroidManifest.xml."
  else
    echo "🛠️ Adding INTERNET permission to AndroidManifest.xml..."
    awk '/<manifest/{print; print "    <uses-permission android:name=\"android.permission.INTERNET\"/>"; next} 1' "$MANIFEST_FILE" > "$MANIFEST_FILE.tmp" && mv "$MANIFEST_FILE.tmp" "$MANIFEST_FILE"
    echo "✅ INTERNET permission added."
  fi
}

export -f add_audio_player_service_Android_permission
