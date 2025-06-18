#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
FORGET_PASSWORD_FILE="$DEST_DIR/forget_password_button.dart"
PUBSPEC_FILE="$FLUTTER_PROJECT_DIR/pubspec.yaml"

function forgetPasswordButtonLocalization(){
  cat <<EOL > "$FORGET_PASSWORD_FILE"
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgotPasswordButton extends StatelessWidget {
  final VoidCallback onTap;
  const ForgotPasswordButton({super.key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Text(
              "forgot_password".tr(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
EOL
}


function forgetPasswordButtonWithoutLocalization(){
  cat <<EOL > "$FORGET_PASSWORD_FILE"
import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget {
  final VoidCallback onTap;
  const ForgotPasswordButton({super.key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Text(
              "Forgot Password ?",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
EOL
}

if grep -q "easy_localization:" "$PUBSPEC_FILE"; then
  echo "✅ easy_localization is present in pubspec.yaml"
  echo "Generating forget password button with localization support."
  forgetPasswordButtonLocalization
else
  echo "❌ easy_localization is NOT present in pubspec.yaml"
  echo "Generating forget password button without localization support."
  forgetPasswordButtonWithoutLocalization
fi

echo "📄 Created forget_password_button.dart file successfully at $FORGET_PASSWORD_FILE"
echo "✅ Forget Password Button template generated successfully."
