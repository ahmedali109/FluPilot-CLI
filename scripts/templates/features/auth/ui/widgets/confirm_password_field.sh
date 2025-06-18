#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
CONFIRM_PASSWORD_FIELD_FILE="$DEST_DIR/confirm_password_field.dart"
PUBSPEC_FILE="$FLUTTER_PROJECT_DIR/pubspec.yaml"

function confirmPasswordFieldLocalization(){
  cat <<EOL > "$CONFIRM_PASSWORD_FIELD_FILE"
  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../logic/auth/auth_cubit.dart';
import 'my_textfield.dart';

class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField({super.key});
  @override
  Widget build(BuildContext context) {
    return MyTextField(
      controller: context.read<AuthCubit>().confirmPasswordController,
      hintText: "confirm_password".tr(),
      obscureText:
          context.watch<AuthCubit>().registerPasswordConfirmationObsecure,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "please_confirm_your_password".tr();
        }
        if (value != context.read<AuthCubit>().passwordController.text) {
          return "passwords_do_not_match".tr();
        }
        return null;
      },
      suffixIcon: GestureDetector(
        onTap: () {
          BlocProvider.of<AuthCubit>(context)
              .toggleRegisterPasswordConfirmationObsecure();
        },
        child: Icon(
          context.watch<AuthCubit>().registerPasswordConfirmationObsecure
              ? Icons.visibility_off
              : Icons.visibility,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
EOL
}

function confirmPasswordFieldWithoutLocalization(){
  cat <<EOL > "$CONFIRM_PASSWORD_FIELD_FILE"
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/auth/auth_cubit.dart';
import 'my_textfield.dart';

class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField({super.key});
  @override
  Widget build(BuildContext context) {
    return MyTextField(
      controller: context.read<AuthCubit>().confirmPasswordController,
      hintText: "Confirm Password",
      obscureText:
          context.watch<AuthCubit>().registerPasswordConfirmationObsecure,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please confirm your password";
        }
        if (value != context.read<AuthCubit>().passwordController.text) {
          return "Passwords do not match";
        }
        return null;
      },
      suffixIcon: GestureDetector(
        onTap: () {
          BlocProvider.of<AuthCubit>(context)
              .toggleRegisterPasswordConfirmationObsecure();
        },
        child: Icon(
          context.watch<AuthCubit>().registerPasswordConfirmationObsecure
              ? Icons.visibility_off
              : Icons.visibility,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
EOL
}

if grep -q "easy_localization:" "$PUBSPEC_FILE"; then
  echo "✅ easy_localization is present in pubspec.yaml"
  echo "Generating confirm password field with localization support."
  confirmPasswordFieldLocalization
else
  echo "❌ easy_localization is NOT present in pubspec.yaml"
  echo "Generating confirm password field without localization support."
  confirmPasswordFieldWithoutLocalization
fi

echo "📄 Created confirm_password_field.dart file successfully at $CONFIRM_PASSWORD_FIELD_FILE"
echo "✅ Confirm Password Field template generated successfully."
