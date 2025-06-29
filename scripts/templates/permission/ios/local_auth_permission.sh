#!/usr/bin/env bash

# Source the iOS permission handler utility
source "$(dirname "${BASH_SOURCE[0]}")/../../../utils/ios_permission_handler.sh"

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

  echo "📂 Found iOS Runner directory in $DEST_DIR/ios/Runner"

  PLIST_FILE="$DEST_DIR/ios/Runner/Info.plist"
  if [ -f "$PLIST_FILE" ]; then
    echo "📂 Found Info.plist in $DEST_DIR/ios/Runner"
    echo "Adding required permissions for local auth..."

    # Add Face ID permission using the safe handler
    add_face_id_permission "$PLIST_FILE"

    echo "✅ Successfully processed local auth permissions"
  else
    echo "❌ Info.plist not found at $PLIST_FILE"
    exit 1
  fi

  echo
}

export -f add_local_auth_ios_permission
