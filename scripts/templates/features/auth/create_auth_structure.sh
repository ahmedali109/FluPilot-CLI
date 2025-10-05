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
  SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")/../../../.." && pwd)"
fi

BASE_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth"

if [ -z "$BASE_DIR" ]; then
  echo "❌ BASE_DIR is not set. Please set it to your Flutter project directory."
  exit 1
fi

echo "📂 Creating auth module structure at ${BASE_DIR}..."

# Create directories
mkdir -p $BASE_DIR/data/models
mkdir -p $BASE_DIR/data/repo
mkdir -p $BASE_DIR/logic/auth

# Create Dart files
touch $BASE_DIR/data/models/app_user.dart
touch $BASE_DIR/data/repo/auth_repo.dart

if grep -q "firebase_auth:" "$FLUTTER_PROJECT_DIR/pubspec.yaml"; then
  touch $BASE_DIR/data/repo/firebase_auth_repo.dart
  source "$SCRIPT_DIR/templates/features/auth/data/repo/firebase_auth_repo.sh"
fi

if grep -q "supabase_flutter:" "$FLUTTER_PROJECT_DIR/pubspec.yaml"; then
  touch $BASE_DIR/data/repo/supabase_auth_repo.dart
  source "$SCRIPT_DIR/templates/features/auth/data/repo/supabase_auth_repo.sh"
fi


touch $BASE_DIR/logic/auth/auth_cubit.dart
touch $BASE_DIR/logic/auth/auth_state.dart

# Fill Dart files with boilerplate code

source "$SCRIPT_DIR/templates/features/auth/data/models/app_user.sh"
source "$SCRIPT_DIR/templates/features/auth/data/repo/auth_repo.sh"

source "$SCRIPT_DIR/templates/features/auth/logic/auth/auth_cubit.sh"
source "$SCRIPT_DIR/templates/features/auth/logic/auth/auth_state.sh"

# Print success message
echo "✅ Auth module structure created successfully!"

# Return to the original directory
echo "🔙 Returning to the original directory..."
echo
echo
cd - >/dev/null || exit 1
cd - >/dev/null || exit 1
