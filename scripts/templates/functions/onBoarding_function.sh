#!/usr/bin/env bash

# Get the absolute path to the real script location, resolving symlinks
# If SCRIPT_DIR is already set (from parent script), use that instead
if [ -z "$SCRIPT_DIR" ]; then
  SOURCE="${BASH_SOURCE[0]}"
  while [ -h "$SOURCE" ]; do
    DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
  done
  SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")/../../.." && pwd)"
fi


source "$SCRIPT_DIR/templates/helper/create_onboarding_screen.sh"

function onBoarding_function(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}"
  if [ -z "$DEST_DIR" ]; then
    echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
    exit 1
  fi
  mkdir -p "$DEST_DIR/lib/features/onboarding" || {
    echo "❌ Failed to create directory $DEST_DIR/lib/features/onboarding"
    exit 1
  }
  echo "📂 Created directory $DEST_DIR/lib/features/onboarding"
  cd "$DEST_DIR" || exit 1
  echo "🛠️ Generating onboarding Screen template in $DEST_DIR"
  echo "✅ introduction_screen found in pubspec.yaml."
  echo "📂 Creating onboarding_screen.dart in $DEST_DIR/lib/features/onboarding..."
  touch "$DEST_DIR/lib/features/onboarding/onboarding_screen.dart" || {
    echo "❌ Failed to create onboarding_screen.dart"
    exit 1
  }

  onBoarding_Screen

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
