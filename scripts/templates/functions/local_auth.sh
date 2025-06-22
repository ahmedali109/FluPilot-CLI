#!/usr/bin/env bash

# Get the absolute path to the real script location, resolving symlinks
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")/../../.." && pwd)"


source "$SCRIPT_DIR/templates/helper/create_local_auth_service.sh"
source "$SCRIPT_DIR/templates/permission/android/local_auth_permission.sh"
source "$SCRIPT_DIR/templates/permission/ios/local_auth_permission.sh"

function local_auth(){
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
  echo "🛠️ Generating local_auth template in $DEST_DIR"
  echo "📂 Creating local_auth_service.dart in $DEST_DIR/lib/core/services..."
  touch "$DEST_DIR/lib/core/services/local_auth_service.dart" || {
    echo "❌ Failed to create local_auth_service.dart"
    exit 1
  }

  create_local_auth_service

  add_local_auth_Android_permission
  add_local_auth_ios_permission

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
