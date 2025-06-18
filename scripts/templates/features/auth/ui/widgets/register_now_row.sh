#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
REGISTER_NOW_ROW_FILE="$DEST_DIR/register_now_row.dart"
PUBSPEC_FILE="$FLUTTER_PROJECT_DIR/pubspec.yaml"

function registerNowRowLocalization(){
  cat <<EOL > "$REGISTER_NOW_ROW_FILE"
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
          "dont_have_account".tr(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        GestureDetector(
          onTap: onRegisterTap,
          child: Text(
            "register_now".tr(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
              fontSize: 13
            ),
          ),
        ),
      ],
    );
  }
}
EOL
}


function registerNowRowWithoutLocalization(){
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
}

if grep -q "easy_localization:" "$PUBSPEC_FILE"; then
  echo "✅ easy_localization is present in pubspec.yaml"
  echo "Generating register now row with localization support."
  registerNowRowLocalization
else
  echo "❌ easy_localization is NOT present in pubspec.yaml"
  echo "Generating register now row without localization support."
  registerNowRowWithoutLocalization
fi

echo "📄 Created register_now_row.dart file successfully at $REGISTER_NOW_ROW_FILE"
echo "✅ Register Now Row template generated successfully."
