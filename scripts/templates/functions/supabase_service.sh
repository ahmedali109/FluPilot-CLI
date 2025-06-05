#!/bin/bash

source ./scripts/templates/helper/create_supabase_service.sh

function supabase_service(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}"

  if [ -z "$DEST_DIR" ]; then
    echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
    exit 1
  fi

  mkdir -p "$DEST_DIR/lib/core/services" || {
    echo "❌ Failed to create directory $DEST_DIR/lib/core/services"
    exit 1
  }

  echo "📂 Created directory $DEST_DIR/lib/core/services"
  cd "$DEST_DIR" || exit 1
  echo "🛠️ Generating supabase_flutter template in $DEST_DIR"

  if ! grep -q "supabase_flutter:" pubspec.yaml; then
    echo "❌ supabase_flutter not found in pubspec.yaml. Please add it under dependencies."
    echo "Example:"
    echo "dependencies:"
    echo "  supabase_flutter: latest_version"
    exit 1
  fi

  echo "📂 Creating supabase_service.dart in $DEST_DIR/lib/core/services..."

  touch "$DEST_DIR/lib/core/services/supabase_service.dart" || {
    echo "❌ Failed to create supabase_service.dart"
    exit 1
  }

  create_supabase_service

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
