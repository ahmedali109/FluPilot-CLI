#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
LOGIN_NOW_ROW_FILE="$DEST_DIR/login_now_row.dart"
cat <<EOL > "$LOGIN_NOW_ROW_FILE"
import 'package:flutter/material.dart';

class LoginNowRow extends StatelessWidget {
  final VoidCallback? onLoginTap;
  const LoginNowRow({super.key, this.onLoginTap});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 5,
      children: [
        Text(
          "Already have an account ?",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        GestureDetector(
          onTap: onLoginTap,
          child: Text(
            "Login now",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        )
      ],
    );
  }
}

EOL

echo "📄 Created login_now_row.dart file successfully at $LOGIN_NOW_ROW_FILE"
echo "✅ Login Now Row template generated successfully."
