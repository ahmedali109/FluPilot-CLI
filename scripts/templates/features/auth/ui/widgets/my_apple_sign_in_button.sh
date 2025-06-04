#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
APPLE_SIGN_IN_BUTTON_FILE="$DEST_DIR/my_apple_sign_in_button.dart"

if [ ! -d "$FLUTTER_PROJECT_DIR/assets/images" ]; then
  echo "❌ assets/images directory does not exist"
  echo "Creating it now..."
  mkdir -p "$FLUTTER_PROJECT_DIR/assets/images"
  echo "✅ Created assets directory successfully."
fi

cp "./scripts/templates/assets/images/apple.png" "${FLUTTER_PROJECT_DIR}/assets/images/"

cat <<EOL > "$APPLE_SIGN_IN_BUTTON_FILE"
import 'package:flutter/material.dart';

class MyAppleSignInButton extends StatelessWidget {
  const MyAppleSignInButton({super.key, this.onPressed});
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
        child: Image.asset(
          "assets/images/apple.png",
          height: 40,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
EOL

echo "📄 Created my_apple_sign_in_button.dart file successfully at $APPLE_SIGN_IN_BUTTON_FILE"
echo "✅ My Apple Sign In button template generated successfully."
