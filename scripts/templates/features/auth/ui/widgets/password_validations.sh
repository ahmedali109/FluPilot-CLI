#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
PASSWORD_VALIDATION_FILE="$DEST_DIR/password_validations.dart"
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

echo "📄 Created password_validations.dart file successfully at $PASSWORD_VALIDATION_FILE"
echo "✅ Password Validations template generated successfully."
