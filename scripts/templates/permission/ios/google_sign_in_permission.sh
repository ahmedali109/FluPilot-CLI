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

  # Create temporary file for configuration
  TMP_CONFIG=$(mktemp)

  # Build configuration with proper indentation (2 tabs for main keys, 3 tabs for nested)
  if [[ " ${AUTH_PACKAGES[*]} " == *"firebase_auth"* ]]; then
    cat >> "$TMP_CONFIG" << EOF
		<!-- Google Sign-in Section (Firebase Auth) -->
		<key>GIDClientID</key>
		<string>$IOS_CLIENT_ID</string>
		<!-- End of the Google Sign-in Section (Firebase Auth) -->
EOF
  fi

  # Add CFBundleURLTypes section
  if [[ " ${AUTH_PACKAGES[*]} " == *"firebase_auth"* ]] && [[ " ${AUTH_PACKAGES[*]} " == *"supabase_flutter"* ]]; then
    cat >> "$TMP_CONFIG" << EOF
		<!-- Google Sign-in URL Scheme (Used by Firebase Auth & Supabase) -->
		<key>CFBundleURLTypes</key>
		<array>
			<dict>
				<key>CFBundleTypeRole</key>
				<string>Editor</string>
				<key>CFBundleURLSchemes</key>
				<array>
					<string>$REVERSED_CLIENT_ID</string>
				</array>
			</dict>
		</array>
		<!-- End of Google Sign-in URL Scheme -->
EOF
  elif [[ " ${AUTH_PACKAGES[*]} " == *"firebase_auth"* ]]; then
    cat >> "$TMP_CONFIG" << EOF
		<!-- Google Sign-in URL Scheme (Firebase Auth) -->
		<key>CFBundleURLTypes</key>
		<array>
			<dict>
				<key>CFBundleTypeRole</key>
				<string>Editor</string>
				<key>CFBundleURLSchemes</key>
				<array>
					<string>$REVERSED_CLIENT_ID</string>
				</array>
			</dict>
		</array>
		<!-- End of Google Sign-in URL Scheme (Firebase Auth) -->
EOF
  elif [[ " ${AUTH_PACKAGES[*]} " == *"supabase_flutter"* ]]; then
    cat >> "$TMP_CONFIG" << EOF
		<!-- Google Sign-in URL Scheme (Supabase) -->
		<key>CFBundleURLTypes</key>
		<array>
			<dict>
				<key>CFBundleTypeRole</key>
				<string>Editor</string>
				<key>CFBundleURLSchemes</key>
				<array>
					<string>$REVERSED_CLIENT_ID</string>
				</array>
			</dict>
		</array>
		<!-- End of Google Sign-in URL Scheme (Supabase) -->
EOF
  fi

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

  echo "✅ Successfully updated Info.plist with Google Sign-In config for: ${AUTH_PACKAGES[*]}"
  echo "📂 Updated Info.plist at $PLIST_FILE"

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}

export -f add_google_signin_ios_config
