#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
REGISTER_BUTTON_FILE="$DEST_DIR/register_button.dart"
PUBSPEC_FILE="$FLUTTER_PROJECT_DIR/pubspec.yaml"

function registerButtonLocalization(){
  cat <<EOL > "$REGISTER_BUTTON_FILE"
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../logic/auth/auth_cubit.dart';
import '../../logic/auth/auth_state.dart';
import 'my_button.dart';

class RegisterButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final void Function(BuildContext) register;
  final bool Function(AuthState) allPasswordRulesPassed;
  const RegisterButton({
    super.key,
    required this.formKey,
    required this.register,
    required this.allPasswordRulesPassed,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final canRegister = allPasswordRulesPassed(state);
        return MyButton(
          onPressed: () {
            final isFormValid = formKey.currentState!.validate();
            if (isFormValid && canRegister) {
              register(context);
            }
            if (!isFormValid) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("please_fill_all_fields".tr()),
                ),
              );
            } else if (!canRegister) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("password_does_not_meet_requirements".tr()),
                ),
              );
            }
          },
          text: "sign_up".tr(),
        );
      },
    );
  }
}
EOL
}

function registerButtonWithoutLocalization(){
  cat <<EOL > "$REGISTER_BUTTON_FILE"
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/auth/auth_cubit.dart';
import '../../logic/auth/auth_state.dart';
import 'my_button.dart';

class RegisterButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final void Function(BuildContext) register;
  final bool Function(AuthState) allPasswordRulesPassed;
  const RegisterButton({
    super.key,
    required this.formKey,
    required this.register,
    required this.allPasswordRulesPassed,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final canRegister = allPasswordRulesPassed(state);
        return MyButton(
          onPressed: () {
            final isFormValid = formKey.currentState!.validate();
            if (isFormValid && canRegister) {
              register(context);
            }
            if (!isFormValid) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Please fill all fields correctly."),
                ),
              );
            } else if (!canRegister) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Password does not meet requirements."),
                ),
              );
            }
          },
          text: "SIGN UP",
        );
      },
    );
  }
}
EOL
}

if grep -q "easy_localization:" "$PUBSPEC_FILE"; then
  echo "✅ easy_localization is present in pubspec.yaml"
  echo "Generating register button with localization support."
  registerButtonLocalization
else
  echo "❌ easy_localization is NOT present in pubspec.yaml"
  echo "Generating register button without localization support."
  registerButtonWithoutLocalization
fi

echo "📄 Created register_button.dart file successfully at $REGISTER_BUTTON_FILE"
echo "✅ Register Button template generated successfully."
