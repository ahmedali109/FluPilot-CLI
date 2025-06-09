#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
LOGIN_NOW_ROW_FILE="$DEST_DIR/login_now_row.dart"
PUBSPEC_FILE="$FLUTTER_PROJECT_DIR/pubspec.yaml"

function loginNowRowLocalization(){
  cat <<EOL > "$LOGIN_NOW_ROW_FILE"
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
          "already_have_account".tr(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        GestureDetector(
          onTap: onLoginTap,
          child: Text(
            "login_now".tr(),
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
}

function loginNowRowWithoutLocalization(){
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
}

if grep -q "easy_localization:" "$PUBSPEC_FILE"; then
  echo "✅ easy_localization is present in pubspec.yaml"
  echo "Generating login now row with localization support."
  loginNowRowLocalization
else
  echo "❌ easy_localization is NOT present in pubspec.yaml"
  echo "Generating login now row without localization support."
  loginNowRowWithoutLocalization
fi

echo "📄 Created login_now_row.dart file successfully at $LOGIN_NOW_ROW_FILE"
echo "✅ Login Now Row template generated successfully."
