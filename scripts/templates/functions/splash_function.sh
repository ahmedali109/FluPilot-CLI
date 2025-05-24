#!/bin/bash

source ./scripts/templates/helper/create_default_splash_yaml.sh

function splash_function(){

  DEST_DIR="${FLUTTER_PROJECT_DIR}"
  cd "$DEST_DIR" || exit 1
  echo "🛠️ Generating splash screen using flutter_native_splash..."

  # Ensure flutter_native_splash is in pubspec.yaml
  if ! grep -q "flutter_native_splash:" pubspec.yaml; then
    echo "❌ flutter_native_splash not found in pubspec.yaml. Please add it under dev_dependencies."
    echo "Example:"
    echo "dev_dependencies:"
    echo "  flutter_native_splash: latest_version"
    exit 1
  fi
  echo "✅ flutter_native_splash found in pubspec.yaml."
  echo "📂 Creating flutter_native_splash.yaml in $DEST_DIR..."
  touch "$DEST_DIR/flutter_native_splash.yaml"
  echo "🔧 Configuring splash screen in flutter_native_splash.yaml..."
  create_default_splash_yaml
  echo "📄 Configured flutter_native_splash.yaml with default settings."

  if [ $? -eq 0 ]; then
    (cd "$DEST_DIR" && flutter pub get && dart run flutter_native_splash:create --path=flutter_native_splash.yaml) && echo "🎉 Splash screen created successfully!"
  else
    echo "❌ Failed to generate splash screen. Please check your pubspec.yaml configuration."
    exit 1
  fi

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
