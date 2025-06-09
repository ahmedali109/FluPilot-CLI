#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
PASSWORD_VALIDATION_FILE="$DEST_DIR/password_validations.dart"
PUBSPEC_FILE="$FLUTTER_PROJECT_DIR/pubspec.yaml"

function passwordValidationsLocalization(){
  cat <<EOL > "$PASSWORD_VALIDATION_FILE"
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/helpers/spacing.dart';

class PasswordValidations extends StatelessWidget {
  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;
  const PasswordValidations({
    super.key,
    required this.hasLowerCase,
    required this.hasUpperCase,
    required this.hasSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildValidationRow(context, 'at_least_1_lowercase'.tr(), hasLowerCase),
        verticalSpace(2),
        buildValidationRow(context, 'at_least_1_uppercase'.tr(), hasUpperCase),
        verticalSpace(2),
        buildValidationRow(
            context, 'at_least_1_special_character'.tr(), hasSpecialCharacters),
        verticalSpace(2),
        buildValidationRow(context, 'at_least_1_number'.tr(), hasNumber),
        verticalSpace(2),
        buildValidationRow(context, 'at_least_8_characters'.tr(), hasMinLength),
      ],
    );
  }

  Widget buildValidationRow(
      BuildContext context, String text, bool hasValidated) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 2.5,
          backgroundColor: Colors.grey,
        ),
        horizontalSpace(6),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            decoration: hasValidated ? TextDecoration.lineThrough : null,
            decorationColor: Colors.grey,
            decorationThickness: 2,
            color: hasValidated
                ? Colors.blueAccent
                : Theme.of(context).colorScheme.primary,
          ),
        )
      ],
    );
  }
}
EOL
}


function passwordValidationsWithoutLocalization(){
  cat <<EOL > "$PASSWORD_VALIDATION_FILE"
import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';

class PasswordValidations extends StatelessWidget {
  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;
  const PasswordValidations({
    super.key,
    required this.hasLowerCase,
    required this.hasUpperCase,
    required this.hasSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildValidationRow(context, 'At least 1 lowercase letter', hasLowerCase),
        verticalSpace(2),
        buildValidationRow(context, 'At least 1 uppercase letter', hasUpperCase),
        verticalSpace(2),
        buildValidationRow(context, 'At least 1 special character', hasSpecialCharacters),
        verticalSpace(2),
        buildValidationRow(context, 'At least 1 number', hasNumber),
        verticalSpace(2),
        buildValidationRow(context, 'At least 8 characters long', hasMinLength),
      ],
    );
  }

  Widget buildValidationRow(BuildContext context, String text, bool hasValidated) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 2.5,
          backgroundColor: Colors.grey,
        ),
        horizontalSpace(6),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            decoration: hasValidated ? TextDecoration.lineThrough : null,
            decorationColor: Colors.grey,
            decorationThickness: 2,
            color: hasValidated ? Colors.blueAccent : Theme.of(context).colorScheme.primary,
          ),
        )
      ],
    );
  }
}
EOL
}

if grep -q "easy_localization:" "$PUBSPEC_FILE"; then
  echo "✅ easy_localization is present in pubspec.yaml"
  echo "Generating password validations with localization support."
  passwordValidationsLocalization
else
  echo "❌ easy_localization is NOT present in pubspec.yaml"
  echo "Generating password validations without localization support."
  passwordValidationsWithoutLocalization
fi

echo "📄 Created password_validations.dart file successfully at $PASSWORD_VALIDATION_FILE"
echo "✅ Password Validations template generated successfully."
