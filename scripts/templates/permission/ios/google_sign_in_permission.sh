#!/bin/bash

function add_google_signin_ios_config() {
  DEST_DIR="${FLUTTER_PROJECT_DIR}"
  if [ -z "$DEST_DIR" ]; then
    echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
    exit 1
  fi

  cd "$DEST_DIR" || exit 1

  echo "🛠️ Adding Google Sign-In configuration to Info.plist in $DEST_DIR/ios/Runner"

  if [ ! -d "$DEST_DIR/ios/Runner" ]; then
    echo "❌ iOS Runner directory not found in $DEST_DIR. Please ensure you have an iOS project set up."
    exit 1
  fi

  PLIST_FILE="$DEST_DIR/ios/Runner/Info.plist"
  if [ ! -f "$PLIST_FILE" ]; then
    echo "❌ Info.plist not found at $PLIST_FILE"
    exit 1
  fi

  if ! command -v gum &> /dev/null; then
    echo "❌ 'gum' is not installed. Install it from https://github.com/charmbracelet/gum"
    exit 1
  fi

  echo "🧾 Found Info.plist — ready to inject configuration."

  IOS_CLIENT_ID=$(gum input --placeholder "Enter your iOS Client ID (GIDServerClientID)")
  REVERSED_CLIENT_ID=$(gum input --placeholder "Enter your REVERSED_CLIENT_ID")

  if [ -z "$IOS_CLIENT_ID" ] || [ -z "$REVERSED_CLIENT_ID" ]; then
    echo "❌ Both values are required. Exiting."
    exit 1
  fi

  echo "📦 Inserting Google Sign-In configuration..."

  TMP_PLIST="${PLIST_FILE}.tmp"

  awk -v config="  <!-- Google Sign-in Section -->\n  <key>GIDServerClientID</key>\n  <string>$IOS_CLIENT_ID</string>\n  <key>CFBundleURLTypes</key>\n  <array>\n    <dict>\n      <key>CFBundleTypeRole</key>\n      <string>Editor</string>\n      <key>CFBundleURLSchemes</key>\n      <array>\n        <string>$REVERSED_CLIENT_ID</string>\n      </array>\n    </dict>\n  </array>\n  <!-- End of the Google Sign-in Section -->" '
    /<\/dict>/ && !x { print config; x=1 }
    { print }
  ' "$PLIST_FILE" > "$TMP_PLIST" && mv "$TMP_PLIST" "$PLIST_FILE"

  echo "✅ Successfully updated Info.plist with Google Sign-In config."
  echo "📂 Updated Info.plist at $PLIST_FILE"
  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}

export -f add_google_signin_ios_config
