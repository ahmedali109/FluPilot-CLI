#!/bin/bash

function add_google_signin_ios_config() {
  DEST_DIR="${FLUTTER_PROJECT_DIR}"
  if [ -z "$DEST_DIR" ]; then
    echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
    exit 1
  fi

  cd "$DEST_DIR" || exit 1

  echo "🛠️ Adding Sign-In configuration to Info.plist in $DEST_DIR/ios/Runner"

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

  # Detect auth package(s) from pubspec.yaml
  AUTH_PACKAGES=()
  if grep -q "firebase_auth:" "$DEST_DIR/pubspec.yaml"; then
    AUTH_PACKAGES+=("firebase_auth")
  fi
  if grep -q "supabase_flutter:" "$DEST_DIR/pubspec.yaml"; then
    AUTH_PACKAGES+=("supabase_flutter")
  fi

  if [ ${#AUTH_PACKAGES[@]} -eq 0 ]; then
    echo "❌ Neither firebase_auth nor supabase_flutter found in pubspec.yaml. Exiting."
    exit 1
  else
    echo "ℹ️ Detected authentication package(s): ${AUTH_PACKAGES[*]}"
  fi

  # Prompt for required values
  if [[ " ${AUTH_PACKAGES[*]} " == *"firebase_auth"* ]]; then
    IOS_CLIENT_ID=$(gum input --placeholder "Enter your iOS Client ID (GIDServerClientID)")
  fi
  if [[ " ${AUTH_PACKAGES[*]} " == *"firebase_auth"* ]] || [[ " ${AUTH_PACKAGES[*]} " == *"supabase_flutter"* ]]; then
    REVERSED_CLIENT_ID=$(gum input --placeholder "Enter your REVERSED_CLIENT_ID")
  fi

  # Insert configuration(s)
  TMP_PLIST="${PLIST_FILE}.tmp"
  CONFIG=""
  if [[ " ${AUTH_PACKAGES[*]} " == *"firebase_auth"* ]]; then
    CONFIG+="  <!-- Google Sign-in Section (Firebase Auth) -->\n  <key>GIDServerClientID</key>\n  <string>$IOS_CLIENT_ID</string>\n  <!-- End of the Google Sign-in Section (Firebase Auth) -->\n"
  fi
  # Only insert CFBundleURLTypes once, with a comment if both are present
  if [[ " ${AUTH_PACKAGES[*]} " == *"firebase_auth"* ]] && [[ " ${AUTH_PACKAGES[*]} " == *"supabase_flutter"* ]]; then
    CONFIG+="  <!-- Google Sign-in URL Scheme (Used by Firebase Auth & Supabase) -->\n  <key>CFBundleURLTypes</key>\n  <array>\n    <dict>\n      <key>CFBundleTypeRole</key>\n      <string>Editor</string>\n      <key>CFBundleURLSchemes</key>\n      <array>\n        <string>$REVERSED_CLIENT_ID</string>\n      </array>\n    </dict>\n  </array>\n  <!-- End of Google Sign-in URL Scheme -->\n"
  elif [[ " ${AUTH_PACKAGES[*]} " == *"firebase_auth"* ]]; then
    CONFIG+="  <!-- Google Sign-in URL Scheme (Firebase Auth) -->\n  <key>CFBundleURLTypes</key>\n  <array>\n    <dict>\n      <key>CFBundleTypeRole</key>\n      <string>Editor</string>\n      <key>CFBundleURLSchemes</key>\n      <array>\n        <string>$REVERSED_CLIENT_ID</string>\n      </array>\n    </dict>\n  </array>\n  <!-- End of Google Sign-in URL Scheme (Firebase Auth) -->\n"
  elif [[ " ${AUTH_PACKAGES[*]} " == *"supabase_flutter"* ]]; then
    CONFIG+="  <!-- Google Sign-in URL Scheme (Supabase) -->\n  <key>CFBundleURLTypes</key>\n  <array>\n    <dict>\n      <key>CFBundleTypeRole</key>\n      <string>Editor</string>\n      <key>CFBundleURLSchemes</key>\n      <array>\n        <string>$REVERSED_CLIENT_ID</string>\n      </array>\n    </dict>\n  </array>\n  <!-- End of Google Sign-in URL Scheme (Supabase) -->\n"
  fi

  awk -v config="$CONFIG" '/<\/dict>/ && !x { print config; x=1 } { print }' "$PLIST_FILE" > "$TMP_PLIST" && mv "$TMP_PLIST" "$PLIST_FILE"

  echo "✅ Successfully updated Info.plist with Google Sign-In config for: ${AUTH_PACKAGES[*]}"
  echo "📂 Updated Info.plist at $PLIST_FILE"
  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}

export -f add_google_signin_ios_config
