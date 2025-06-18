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

  echo "📂 Found iOS Runner directory in $DEST_DIR/ios/Runner"

  PLIST_FILE="$DEST_DIR/ios/Runner/Info.plist"
  if [ -f "$PLIST_FILE" ]; then
    echo "📂 Found Info.plist in $DEST_DIR/ios/Runner"
    echo "Adding required permissions for local auth..."

    # Create temporary file for configuration
    TMP_CONFIG=$(mktemp)

    # Build local auth permissions with proper indentation (2 tabs for main keys)
    cat >> "$TMP_CONFIG" << 'EOF'
		<key>NSFaceIDUsageDescription</key>
		<string>This app requires access to Face ID for authentication purposes.</string>
EOF

    # Insert configuration before the last </dict> (which is followed by </plist>)
    TMP_PLIST="${PLIST_FILE}.tmp"

    # Use awk to insert the configuration at the right place
    awk '
    BEGIN {
      # Read the configuration file
      while ((getline line < "'$TMP_CONFIG'") > 0) {
        config = config line "\n"
      }
      close("'$TMP_CONFIG'")
    }
    /<\/dict>$/ && !found_last_dict {
      # Check if next line is </plist>
      next_line_num = NR + 1
      if ((getline next_line) > 0) {
        if (next_line ~ /<\/plist>/) {
          # This is the last </dict> before </plist>
          print config $0
          print next_line
          found_last_dict = 1
          next
        } else {
          # Not the last </dict>, print current line and put back next_line
          print $0
          print next_line
          next
        }
      }
    }
    { print }
    ' "$PLIST_FILE" > "$TMP_PLIST" && mv "$TMP_PLIST" "$PLIST_FILE"

    # Clean up temporary file
    rm -f "$TMP_CONFIG"

    echo "✅ Successfully added local auth permissions to Info.plist"
  else
    echo "❌ Info.plist not found at $PLIST_FILE"
    exit 1
  fi

  echo
}

export -f add_local_auth_ios_permission
