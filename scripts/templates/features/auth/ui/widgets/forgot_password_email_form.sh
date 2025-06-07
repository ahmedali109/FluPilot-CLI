#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
FORGOT_PASSWORD_EMAIL_FORM_FILE="$DEST_DIR/forgot_password_email_form.dart"
cat <<EOL > "$FORGOT_PASSWORD_EMAIL_FORM_FILE"
import 'package:flutter/material.dart';
import 'my_textfield.dart';

class ForgotPasswordEmailForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final String? Function(String?) validator;

  const ForgotPasswordEmailForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter your email",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          MyTextField(
            controller: emailController,
            hintText: "email",
            obscureText: false,
            validator: validator,
            suffixIcon: Icon(
              Icons.email_outlined,
              color: Theme.of(context).colorScheme.primary.withAlpha(60),
            ),
          ),
        ],
      ),
    );
  }
}

EOL

echo "📄 Created forgot_password_email_form.dart file successfully at $FORGOT_PASSWORD_EMAIL_FORM_FILE"
echo "✅ Forgot Password Email Form template generated successfully."
