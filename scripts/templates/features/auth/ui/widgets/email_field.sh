#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
EMAIL_FIELD_FILE="$DEST_DIR/email_field.dart"
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

echo "📄 Created email_field.dart file successfully at $EMAIL_FIELD_FILE"
echo "✅ Email Field template generated successfully."
