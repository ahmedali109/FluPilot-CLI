#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
REGISTER_NOW_ROW_FILE="$DEST_DIR/register_now_row.dart"
cat <<EOL > "$REGISTER_NOW_ROW_FILE"
import 'package:flutter/material.dart';

class RegisterNowRow extends StatelessWidget {
  final VoidCallback? onRegisterTap;
  const RegisterNowRow({super.key, this.onRegisterTap});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 5,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        GestureDetector(
          onTap: onRegisterTap,
          child: Text(
            "Register now",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
EOL

echo "📄 Created register_now_row.dart file successfully at $REGISTER_NOW_ROW_FILE"
echo "✅ Register Now Row template generated successfully."
