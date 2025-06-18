#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
FORGOT_PASSWORD_TITLE_FILE="$DEST_DIR/forgot_password_title.dart"
PUBSPEC_FILE="$FLUTTER_PROJECT_DIR/pubspec.yaml"

function forgotPasswordTitleLocalization(){
  cat <<EOL > "$FORGOT_PASSWORD_TITLE_FILE"
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgotPasswordTitle extends StatelessWidget {
  const ForgotPasswordTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "forgot_password_title".tr(),
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "forgot_password_subtitle".tr(),
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.inversePrimary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
EOL
}


function forgotPasswordTitleWithoutLocalization(){
  cat <<EOL > "$FORGOT_PASSWORD_TITLE_FILE"
import 'package:flutter/material.dart';

class ForgotPasswordTitle extends StatelessWidget {
  const ForgotPasswordTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Forgot Password",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Don't worry! It happens. Please enter the email address associated with your account.",
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.inversePrimary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
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
  echo "Generating forgot password title with localization support."
  forgotPasswordTitleLocalization
else
  echo "❌ easy_localization is NOT present in pubspec.yaml"
  echo "Generating forgot password title without localization support."
  forgotPasswordTitleWithoutLocalization
fi

echo "📄 Created forgot_password_title.dart file successfully at $FORGOT_PASSWORD_TITLE_FILE"
echo "✅ Forgot Password Title template generated successfully."
