#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
FORGOT_PASSWORD_CONTENT_FILE="$DEST_DIR/forgot_password_content.dart"
cat <<EOL > "$FORGOT_PASSWORD_CONTENT_FILE"
import 'package:flutter/material.dart';
import 'forgot_password_email_form.dart';
import 'reset_link_button.dart';
import 'forgot_password_success_state.dart';

class ForgotPasswordContent extends StatelessWidget {
  final bool isLinkSent;
  final bool isLoading;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final String? Function(String?) emailValidator;
  final VoidCallback onSendResetLink;
  final VoidCallback onResendPressed;

  const ForgotPasswordContent({
    super.key,
    required this.isLinkSent,
    required this.isLoading,
    required this.formKey,
    required this.emailController,
    required this.emailValidator,
    required this.onSendResetLink,
    required this.onResendPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLinkSent) {
      return Column(
        children: [
          ForgotPasswordEmailForm(
            formKey: formKey,
            emailController: emailController,
            validator: emailValidator,
          ),
          const SizedBox(height: 40),
          ResetLinkButton(isLoading: isLoading, onPressed: onSendResetLink),
        ],
      );
    } else {
      return ForgotPasswordSuccessState(onResendPressed: onResendPressed);
    }
  }
}

EOL

echo "📄 Created forgot_password_content.dart file successfully at $FORGOT_PASSWORD_CONTENT_FILE"
echo "✅ Forgot Password Content template generated successfully."
