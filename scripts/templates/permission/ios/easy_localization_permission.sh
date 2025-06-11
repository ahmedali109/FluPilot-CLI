#!/bin/bash

function add_easy_localization_ios_permission() {
  DEST_DIR="${FLUTTER_PROJECT_DIR}"
  if [ -z "$DEST_DIR" ]; then
    echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
    exit 1
  fi
  echo "🛠️ Adding iOS permissions for easy localization in $DEST_DIR/ios/Runner"
  if [ ! -d "$DEST_DIR/ios/Runner" ]; then
    echo "❌ iOS Runner directory not found in $DEST_DIR. Please ensure you have an iOS project set up."
    exit 1
  fi
  echo "📂 Found iOS Runner directory in $DEST_DIR/ios/Runner"
  PLIST_FILE="$DEST_DIR/ios/Runner/Info.plist"
  if [ -f "$PLIST_FILE" ]; then
    echo "📂 Found Info.plist in $DEST_DIR/ios/Runner"
    echo "Adding required permissions for easy localization..."
    # Insert permissions before the last </dict> (which is followed by </plist>)
    TMP_PLIST="${PLIST_FILE}.tmp"
    awk '/<\/dict>/ { dict_line = $0; next } /<\/plist>/ { print "  <key>CFBundleLocalizations</key>\n  <array>\n    <string>en</string>\n    <string>ar</string>\n    <string>de</string>\n    <string>fr</string>\n    <string>es</string>\n    <string>it</string>\n    <string>ja</string>\n    <string>ko</string>\n    <string>zh</string>\n  </array>\n" dict_line; print; next } { if (dict_line) { print dict_line; dict_line = "" } print }' "$PLIST_FILE" > "$TMP_PLIST" && mv "$TMP_PLIST" "$PLIST_FILE"
  fi
  echo
}

export -f add_easy_localization_ios_permission
