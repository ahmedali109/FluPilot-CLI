#!/bin/bash

function add_local_auth_ios_permission() {
  DEST_DIR="${FLUTTER_PROJECT_DIR}"
  if [ -z "$DEST_DIR" ]; then
    echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
    exit 1
  fi
  echo "🛠️ Adding iOS permissions for local auth in $DEST_DIR/ios/Runner"
  if [ ! -d "$DEST_DIR/ios/Runner" ]; then
    echo "❌ iOS Runner directory not found in $DEST_DIR. Please ensure you have an iOS project set up."
    exit 1
  fi
  echo "📂 Found iOS Runner directory in $DEST_DIR/ios/Runner/"
  PLIST_FILE="$DEST_DIR/ios/Runner/Info.plist"
  if [ -f "$PLIST_FILE" ]; then
    echo "📂 Found Info.plist in $DEST_DIR/ios/Runner/"
    echo "Adding required permissions for local auth..."
    # Insert permissions before </dict>
    TMP_PLIST="${PLIST_FILE}.tmp"
    awk '/<\/dict>/ && !x {print "  <key>NSFaceIDUsageDescription</key>\n  <string>This app requires access to Face ID for authentication purposes.</string>"; x=1} {print}' "$PLIST_FILE" > "$TMP_PLIST" && mv "$TMP_PLIST" "$PLIST_FILE"
  fi
  echo
}

export -f add_local_auth_ios_permission
