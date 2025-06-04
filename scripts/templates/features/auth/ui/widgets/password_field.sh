#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
PASSWORD_FIELD_FILE="$DEST_DIR/password_field.dart"
cat <<EOL > "$PASSWORD_FIELD_FILE"
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/auth/auth_cubit.dart';
import 'my_textfield.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});
  @override
  Widget build(BuildContext context) {
    return MyTextField(
      controller: context.read<AuthCubit>().passwordController,
      hintText: "Password",
      obscureText: context.watch<AuthCubit>().loginPasswordObsecure,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your password";
        }
        return null;
      },
      suffixIcon: GestureDetector(
        onTap: () {
          BlocProvider.of<AuthCubit>(context).toggleLoginPasswordObsecure();
        },
        child: Icon(
          context.watch<AuthCubit>().loginPasswordObsecure
              ? Icons.visibility_off
              : Icons.visibility,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

EOL

echo "📄 Created password_field.dart file successfully at $PASSWORD_FIELD_FILE"
echo "✅ Password Field template generated successfully."
