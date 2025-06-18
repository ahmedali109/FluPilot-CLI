#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
FORGOT_PASSWORD_EMAIL_FORM_FILE="$DEST_DIR/forgot_password_email_form.dart"
PUBSPEC_FILE="$FLUTTER_PROJECT_DIR/pubspec.yaml"

function forgotPasswordEmailFormLocalization(){
  cat <<EOL > "$FORGOT_PASSWORD_EMAIL_FORM_FILE"
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
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
            "enter_email".tr(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          MyTextField(
            controller: emailController,
            hintText: "email".tr(),
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
}


function forgotPasswordEmailFormWithoutLocalization() {
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
}

if grep -q "easy_localization:" "$PUBSPEC_FILE"; then
  echo "✅ easy_localization is present in pubspec.yaml"
  echo "Generating forgot password email form with localization support."
  forgotPasswordEmailFormLocalization
else
  echo "❌ easy_localization is NOT present in pubspec.yaml"
  echo "Generating forgot password email form without localization support."
  forgotPasswordEmailFormWithoutLocalization
fi

echo "📄 Created forgot_password_email_form.dart file successfully at $FORGOT_PASSWORD_EMAIL_FORM_FILE"
echo "✅ Forgot Password Email Form template generated successfully."
