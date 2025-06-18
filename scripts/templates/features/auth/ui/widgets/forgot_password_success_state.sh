#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
FORGOT_PASSWORD_SUCCESS_STATE_FILE="$DEST_DIR/forgot_password_success_state.dart"
PUBSPEC_FILE="$FLUTTER_PROJECT_DIR/pubspec.yaml"

function forgotPasswordSuccessStateLocalization(){
  cat <<EOL > "$FORGOT_PASSWORD_SUCCESS_STATE_FILE"
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgotPasswordSuccessState extends StatelessWidget {
  final VoidCallback onResendPressed;

  const ForgotPasswordSuccessState({super.key, required this.onResendPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.green.withAlpha(50),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.green.withAlpha(30), width: 1),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.check_circle_outline,
                size: 48,
                color: Colors.green,
              ),
              const SizedBox(height: 16),
              Text(
                "reset_link_sent".tr(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "reset_link_sent_message".tr(),
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        TextButton(
          onPressed: onResendPressed,
          child: Text(
            "send_reset_link".tr(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
EOL
}


function forgotPasswordSuccessStateWithoutLocalization(){
  cat <<EOL > "$FORGOT_PASSWORD_SUCCESS_STATE_FILE"
import 'package:flutter/material.dart';

class ForgotPasswordSuccessState extends StatelessWidget {
  final VoidCallback onResendPressed;

  const ForgotPasswordSuccessState({super.key, required this.onResendPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.green.withAlpha(50),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.green.withAlpha(30), width: 1),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.check_circle_outline,
                size: 48,
                color: Colors.green,
              ),
              const SizedBox(height: 16),
              const Text(
                "Reset link sent!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "We have sent a password reset link to your email address. Please check your inbox and follow the instructions",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        TextButton(
          onPressed: onResendPressed,
          child: Text(
            "Send Reset Link",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
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
  echo "Generating forgot password success state with localization support."
  forgotPasswordSuccessStateLocalization
else
  echo "❌ easy_localization is NOT present in pubspec.yaml"
  echo "Generating forgot password success state without localization support."
  forgotPasswordSuccessStateWithoutLocalization
fi

echo "📄 Created forgot_password_success_state.dart file successfully at $FORGOT_PASSWORD_SUCCESS_STATE_FILE"
echo "✅ Forgot Password Success State template generated successfully."
