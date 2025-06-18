#!/bin/bash

function add_local_auth_Android_permission(){
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

  if grep -q '<uses-permission android:name="android.permission.USE_BIOMETRIC"' "$MANIFEST_FILE"; then
    echo "ℹ️ USE_BIOMETRIC permission already exists in AndroidManifest.xml."
  else
    echo "🛠️ Adding USE_BIOMETRIC permission to AndroidManifest.xml..."
    awk '/<manifest/{print; print "    <uses-permission android:name=\"android.permission.USE_BIOMETRIC\"/>"; next} 1' "$MANIFEST_FILE" > "$MANIFEST_FILE.tmp" && mv "$MANIFEST_FILE.tmp" "$MANIFEST_FILE"
    echo "✅ USE_BIOMETRIC permission added."
  fi
}

export -f add_local_auth_Android_permission
