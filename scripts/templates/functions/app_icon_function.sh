#!/usr/bin/env bash

# Get the absolute path to the real script location, resolving symlinks
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")/../../.." && pwd)"


source "$SCRIPT_DIR/templates/helper/create_default_icons_yaml.sh"

function app_icon_function(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}"
  cd "$DEST_DIR" || exit 1
  echo "🛠️ Generating app icon using flutter_launcher_icons..."
  echo "📂 Creating flutter_launcher_icons.yaml in $DEST_DIR..."
  touch "$DEST_DIR/flutter_launcher_icons.yaml"
  echo "🔧 Configuring app icon in flutter_launcher_icons.yaml..."
  create_default_icon_yaml
  echo "📄 Configured flutter_launcher_icons.yaml with default settings."

  if [ $? -eq 0 ]; then
    (cd "$DEST_DIR" && flutter pub get && dart run flutter_launcher_icons) && echo "🎉 App icon created successfully!"
  else
    echo "❌ Failed to generate app icon. Please check your pubspec.yaml configuration."
    exit 1
  fi
  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}

# Function to generate the app icon
export -f app_icon_function
