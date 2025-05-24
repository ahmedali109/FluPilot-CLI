#!/bin/bash
# Cross-platform helper to generate a default flutter_launcher_icons.yaml in the Flutter project directory

function create_default_icon_yaml() {
  DEST_DIR="${FLUTTER_PROJECT_DIR}"
  ICON_FILE="$DEST_DIR/flutter_launcher_icons.yaml"

  cat <<EOL > "$ICON_FILE"
# flutter pub run flutter_launcher_icons
flutter_launcher_icons:
  android: true
  image_path_android: "assets/images/icon.png"
  min_sdk_android: 21 # android min sdk min:16, default 21
  # adaptive_icon_background: "assets/images/background.png"
  # adaptive_icon_foreground: "assets/images/foreground.png"
  # adaptive_icon_monochrome: "assets/images/monochrome.png"

  ios: true
  image_path_ios: "assets/images/icon.png"
  remove_alpha_channel_ios: true
  # image_path_ios_dark_transparent: "assets/images/icon_dark.png"
  # image_path_ios_tinted_grayscale: "assets/images/icon_tinted.png"
  # desaturate_tinted_to_grayscale_ios: true
EOL

  echo "✅ Created default flutter_launcher_icons.yaml in $DEST_DIR"
}

# Export the function for use in other scripts
export -f create_default_icon_yaml
