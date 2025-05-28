#!/bin/bash

function add_image_picker_ios_permission() {
  DEST_DIR="${FLUTTER_PROJECT_DIR}"
  if [ -z "$DEST_DIR" ]; then
    echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
    exit 1
  fi
  echo "🛠️ Adding iOS permissions for image picker in $DEST_DIR/ios/Runner"
  if [ ! -d "$DEST_DIR/ios/Runner" ]; then
    echo "❌ iOS Runner directory not found in $DEST_DIR. Please ensure you have an iOS project set up."
    exit 1
  fi
  echo "📂 Found iOS Runner directory in $DEST_DIR/ios/Runner/"
  PLIST_FILE="$DEST_DIR/ios/Runner/Info.plist"
  if [ -f "$PLIST_FILE" ]; then
    echo "📂 Found Info.plist in $DEST_DIR/ios/Runner/"
    echo "Adding required permissions for image picker..."
    # Insert permissions before </dict>
    TMP_PLIST="${PLIST_FILE}.tmp"
    awk '/<\/dict>/ && !x {print "  <key>NSCameraUsageDescription</key>\n  <string>This app requires access to the camera to record videos.</string>\n  <key>NSMicrophoneUsageDescription</key>\n  <string>This app requires access to the microphone to record audio for videos.</string>\n  <key>NSPhotoLibraryUsageDescription</key>\n  <string>This app requires access to the photo library to select and play videos.</string>"; x=1} {print}' "$PLIST_FILE" > "$TMP_PLIST" && mv "$TMP_PLIST" "$PLIST_FILE"
  fi
  echo
}

export -f add_image_picker_ios_permission
