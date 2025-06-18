#!/bin/bash
source ./scripts/templates/helper/create_easy_localization_structure.sh
source ./scripts/templates/permission/ios/easy_localization_permission.sh

function easy_localization(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}"

  if [ -z "$DEST_DIR" ]; then
    echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
    exit 1
  fi

  mkdir -p "$DEST_DIR/assets/l10n" || {
    echo "❌ Failed to create directory $DEST_DIR/assets/l10n"
    exit 1
  }

  echo "📂 Created directory $DEST_DIR/assets/l10n"
  cd "$DEST_DIR" || exit 1
  echo "🛠️ Generating easy_localization template in $DEST_DIR"

  if ! grep -q "easy_localization:" pubspec.yaml; then
    echo "❌ easy_localization not found in pubspec.yaml. Please add it under dependencies."
    echo "Example:"
    echo "dependencies:"
    echo "  easy_localization: latest_version"
    exit 1
  fi

  echo "📂 Creating localizations in $DEST_DIR/assets/l10n..."
  # Create localization files for all supported languages
  touch "$DEST_DIR/assets/l10n/en.json" || {
    echo "❌ Failed to create en.json"
    exit 1
  }

  touch "$DEST_DIR/assets/l10n/ar.json" || {
    echo "❌ Failed to create ar.json"
    exit 1
  }

  touch "$DEST_DIR/assets/l10n/de.json" || {
    echo "❌ Failed to create de.json"
    exit 1
  }

  touch "$DEST_DIR/assets/l10n/fr.json" || {
    echo "❌ Failed to create fr.json"
    exit 1
  }

  touch "$DEST_DIR/assets/l10n/es.json" || {
    echo "❌ Failed to create es.json"
    exit 1
  }

  touch "$DEST_DIR/assets/l10n/it.json" || {
    echo "❌ Failed to create it.json"
    exit 1
  }

  touch "$DEST_DIR/assets/l10n/ja.json" || {
    echo "❌ Failed to create ja.json"
    exit 1
  }

  touch "$DEST_DIR/assets/l10n/ko.json" || {
    echo "❌ Failed to create ko.json"
    exit 1
  }

  touch "$DEST_DIR/assets/l10n/zh.json" || {
    echo "❌ Failed to create zh.json"
    exit 1
  }

  echo "✅ Created localization files for: en, ar, de, fr, es, it, ja, ko, zh"

  create_easy_localization_structure

  add_easy_localization_ios_permission

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
  cd - >/dev/null || exit 1
}
