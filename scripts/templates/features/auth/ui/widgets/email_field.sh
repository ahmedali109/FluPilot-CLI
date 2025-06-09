#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
EMAIL_FIELD_FILE="$DEST_DIR/email_field.dart"
PUBSPEC_FILE="$FLUTTER_PROJECT_DIR/pubspec.yaml"

function emailFieldLocalization(){
  cat <<EOL > "$EMAIL_FIELD_FILE"
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/helpers/app_regex.dart';
import '../../logic/auth/auth_cubit.dart';
import 'my_textfield.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key});
  @override
  Widget build(BuildContext context) {
    return MyTextField(
      controller: context.read<AuthCubit>().emailController,
      hintText: "email".tr(),
      obscureText: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "please_enter_your_email".tr();
        }
        if (!AppRegex.isEmailValid(value)) {
          return "please_enter_valid_email".tr();
        }
        return null;
      },
    );
  }
}

EOL
}

function emailFieldWithoutLocalization(){
  cat <<EOL > "$EMAIL_FIELD_FILE"
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/app_regex.dart';
import '../../logic/auth/auth_cubit.dart';
import 'my_textfield.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key});
  @override
  Widget build(BuildContext context) {
    return MyTextField(
      controller: context.read<AuthCubit>().emailController,
      hintText: "Email",
      obscureText: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your email";
        }
        if (!AppRegex.isEmailValid(value)) {
          return "Please enter a valid email";
        }
        return null;
      },
    );
  }
}
EOL
}

if grep -q "easy_localization:" "$PUBSPEC_FILE"; then
  echo "✅ easy_localization is present in pubspec.yaml"
  echo "Generating email field with localization support."
  emailFieldLocalization
else
  echo "❌ easy_localization is NOT present in pubspec.yaml"
  echo "Generating email field without localization support."
  emailFieldWithoutLocalization
fi

echo "📄 Created email_field.dart file successfully at $EMAIL_FIELD_FILE"
echo "✅ Email Field template generated successfully."
