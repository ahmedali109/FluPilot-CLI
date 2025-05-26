#!/bin/bash

source ./scripts/templates/helper/create_onboarding_screen.sh

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
  if ! grep -q "introduction_screen:" pubspec.yaml; then
    echo "❌ introduction_screen not found in pubspec.yaml. Please add it under dependencies."
    echo "Example:"
    echo "dependencies:"
    echo "  introduction_screen: latest_version"
    exit 1
  fi
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
