#!/bin/bash

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
  static const String supabaseUrl = "https://liikflvgsokyrceuunim.supabase.co";
  static const String supabaseAnonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxpaWtmbHZnc29reXJjZXV1bmltIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDkwNjU2NzUsImV4cCI6MjA2NDY0MTY3NX0.kwnWQ9FhNPBEQ7U6akh6PFP_m-9CfYoR7HCrFwfpgh4";
  static const String webClientId = "888545710373-ji0dahmu5kjtvgeietvr7ej6fuk3mrmr.apps.googleusercontent.com";
  static const String iosClientId = "888545710373-0i5fqeeqti3o5tk6rbclh7oo1f5g5a8h.apps.googleusercontent.com";
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
