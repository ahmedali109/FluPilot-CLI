#!/usr/bin/env bash

function appStrings(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}"

  if [ -z "$DEST_DIR" ]; then
    echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
    exit 1
  fi

  mkdir -p "$DEST_DIR/lib/core/constants" || {
    echo "❌ Failed to create directory $DEST_DIR/lib/core/constants"
    exit 1
  }

  echo "📂 Created directory $DEST_DIR/lib/core/constants"
  cd "$DEST_DIR" || exit 1
  echo "🛠️ Generating extensions template in $DEST_DIR"

  echo "📂 Creating app_strings.dart in $DEST_DIR/lib/core/constants..."
  touch "$DEST_DIR/lib/core/constants/app_strings.dart" || {
    echo "❌ Failed to create app_strings.dart"
    exit 1
  }

function create_app_strings() {
  cat <<EOL > "$DEST_DIR/lib/core/constants/app_strings.dart"
class AppStrings {
  AppStrings._();
  static const String supabaseUrl = "Add your Supabase URL here";
  static const String supabaseAnonKey = "Add your Supabase Anon Key here";
  static const String webClientId = "Add your Web Client ID here";
  static const String iosClientId = "Add your iOS Client ID here";
}

class AppLocale {
  AppLocale._();
  static const String english = "en";
  static const String arabic = "ar";
  static const String german = "de";
  static const String french = "fr";
  static const String spanish = "es";
  static const String italian = "it";
  static const String japanese = "ja";
  static const String korean = "ko";
  static const String chinese = "zh";
}
EOL
    echo "📄 app_strings.dart created successfully."
}
  create_app_strings || {
    echo "❌ Failed to create app_strings.dart"
    exit 1
  }
  echo "✅ app_strings.dart created successfully in $DEST_DIR/lib/core/constants/app_strings.dart"

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
