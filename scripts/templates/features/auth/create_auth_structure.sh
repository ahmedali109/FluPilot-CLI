#!/bin/bash

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
mkdir -p $BASE_DIR/ui/widgets

# Create Dart files
touch $BASE_DIR/data/models/app_user.dart
touch $BASE_DIR/data/repo/auth_repo.dart

if grep -q "firebase_auth:" "$FLUTTER_PROJECT_DIR/pubspec.yaml"; then
  touch $BASE_DIR/data/repo/firebase_auth_repo.dart
  source ./scripts/templates/features/auth/data/repo/firebase_auth_repo.sh
fi

if grep -q "supabase_flutter:" "$FLUTTER_PROJECT_DIR/pubspec.yaml"; then
  touch $BASE_DIR/data/repo/supabase_auth_repo.dart
  source ./scripts/templates/features/auth/data/repo/supabase_auth_repo.sh
fi


touch $BASE_DIR/logic/auth/auth_cubit.dart
touch $BASE_DIR/logic/auth/auth_state.dart

touch $BASE_DIR/ui/widgets/confirm_password_field.dart
touch $BASE_DIR/ui/widgets/email_field.dart
touch $BASE_DIR/ui/widgets/forget_password_button.dart
touch $BASE_DIR/ui/widgets/login_now_row.dart
touch $BASE_DIR/ui/widgets/my_apple_sign_in_button.dart
touch $BASE_DIR/ui/widgets/my_button.dart
touch $BASE_DIR/ui/widgets/my_google_sign_in_button.dart
touch $BASE_DIR/ui/widgets/my_textfield.dart
touch $BASE_DIR/ui/widgets/name_field.dart
touch $BASE_DIR/ui/widgets/password_field.dart
touch $BASE_DIR/ui/widgets/password_validations.dart
touch $BASE_DIR/ui/widgets/register_button.dart
touch $BASE_DIR/ui/widgets/register_now_row.dart
touch $BASE_DIR/ui/widgets/social_login_row.dart

touch $BASE_DIR/ui/login_or_register.dart
touch $BASE_DIR/ui/login_page.dart
touch $BASE_DIR/ui/register_page.dart

# Fill Dart files with boilerplate code

source ./scripts/templates/features/auth/data/models/app_user.sh
source ./scripts/templates/features/auth/data/repo/auth_repo.sh

source ./scripts/templates/features/auth/logic/auth/auth_cubit.sh
source ./scripts/templates/features/auth/logic/auth/auth_state.sh

source ./scripts/templates/features/auth/ui/widgets/confirm_password_field.sh
source ./scripts/templates/features/auth/ui/widgets/email_field.sh
source ./scripts/templates/features/auth/ui/widgets/forget_password_button.sh
source ./scripts/templates/features/auth/ui/widgets/login_now_row.sh
source ./scripts/templates/features/auth/ui/widgets/my_apple_sign_in_button.sh
source ./scripts/templates/features/auth/ui/widgets/my_button.sh
source ./scripts/templates/features/auth/ui/widgets/my_google_sign_in_button.sh
source ./scripts/templates/features/auth/ui/widgets/my_textfield.sh
source ./scripts/templates/features/auth/ui/widgets/password_validations.sh
source ./scripts/templates/features/auth/ui/widgets/name_field.sh
source ./scripts/templates/features/auth/ui/widgets/password_field.sh
source ./scripts/templates/features/auth/ui/widgets/register_button.sh
source ./scripts/templates/features/auth/ui/widgets/register_now_row.sh
source ./scripts/templates/features/auth/ui/widgets/social_login_row.sh

source ./scripts/templates/features/auth/ui/login_or_register.sh
source ./scripts/templates/features/auth/ui/login_page.sh
source ./scripts/templates/features/auth/ui/register_page.sh

# Print success message
echo "✅ Auth module structure created successfully!"

# Return to the original directory
echo "🔙 Returning to the original directory..."
echo
echo
cd - >/dev/null || exit 1
cd - >/dev/null || exit 1
