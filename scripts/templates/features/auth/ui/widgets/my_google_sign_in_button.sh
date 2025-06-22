#!/usr/bin/env bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
GOOGLE_SIGN_IN_BUTTON_FILE="$DEST_DIR/my_google_sign_in_button.dart"

if [ ! -d "$FLUTTER_PROJECT_DIR/assets/images" ]; then
  echo "❌ assets/images directory does not exist"
  echo "Creating it now..."
  mkdir -p "$FLUTTER_PROJECT_DIR/assets/images"
  mkdir -p "$FLUTTER_PROJECT_DIR/assets/icons"
  echo "✅ Created assets directory successfully."
  # Add Assets directory to pubspec.yaml
  # Get the absolute path to the real script location, resolving symlinks
  # If SCRIPT_DIR is already set (from parent script), use that instead
  if [ -z "$SCRIPT_DIR" ]; then
    SOURCE="${BASH_SOURCE[0]}"
    while [ -h "$SOURCE" ]; do
      DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
      SOURCE="$(readlink "$SOURCE")"
      [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
    done
    SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")/../../../../../.." && pwd)"
  fi
  source "$SCRIPT_DIR/templates/helper/add_assets_yaml.sh"
  echo "✅ Added assets directory to pubspec.yaml"
fi

cp "./scripts/templates/assets/images/google.png" "${FLUTTER_PROJECT_DIR}/assets/images/"

cat <<EOL > "$GOOGLE_SIGN_IN_BUTTON_FILE"
import 'package:flutter/material.dart';

class MyGoogleSignInButton extends StatelessWidget {
  const MyGoogleSignInButton({super.key, this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        child: Image.asset("assets/images/google.png", height: 40),
      ),
    );
  }
}

EOL

echo "📄 Created my_google_sign_in_button.dart file successfully at $GOOGLE_SIGN_IN_BUTTON_FILE"
echo "✅ Google Sign In button template generated successfully."
