#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
FORGOT_PASSWORD_HEADER_FILE="$DEST_DIR/forgot_password_header.dart"
PUBSPEC_FILE="$FLUTTER_PROJECT_DIR/pubspec.yaml"

function forgotPasswordHeaderLocalization(){
  cat <<EOL > "$FORGOT_PASSWORD_HEADER_FILE"
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgotPasswordHeader extends StatelessWidget {
  final VoidCallback onBackPressed;

  const ForgotPasswordHeader({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        children: [
          IconButton(
            onPressed: onBackPressed,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            "back_to_login".tr(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
EOL
}


function forgotPasswordHeaderWithoutLocalization(){
  cat <<EOL > "$FORGOT_PASSWORD_HEADER_FILE"
import 'package:flutter/material.dart';

class ForgotPasswordHeader extends StatelessWidget {
  final VoidCallback onBackPressed;

  const ForgotPasswordHeader({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        children: [
          IconButton(
            onPressed: onBackPressed,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            "back to login",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
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
  echo "Generating forgot password header with localization support."
  forgotPasswordHeaderLocalization
else
  echo "❌ easy_localization is NOT present in pubspec.yaml"
  echo "Generating forgot password header without localization support."
  forgotPasswordHeaderWithoutLocalization
fi

echo "📄 Created forgot_password_header.dart file successfully at $FORGOT_PASSWORD_HEADER_FILE"
echo "✅ Forgot Password Header template generated successfully."
