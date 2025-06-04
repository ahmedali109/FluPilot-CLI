#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui"
REGISTER_FILE="$DEST_DIR/register_page.dart"
cat <<EOL > "$REGISTER_FILE"
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/auth/auth_cubit.dart';
import '../logic/auth/auth_state.dart';
import 'widgets/confirm_password_field.dart';
import 'widgets/email_field.dart';
import 'widgets/login_now_row.dart';
import 'widgets/name_field.dart';
import 'widgets/password_field.dart';
import 'widgets/password_validations.dart';
import 'widgets/register_button.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key, this.onLoginTap});

  final VoidCallback? onLoginTap;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool allPasswordRulesPassed(AuthState state) {
    return state is PasswordValidationsState &&
        state.hasLowercase &&
        state.hasUppercase &&
        state.hasSpecialCharacters &&
        state.hasNumber &&
        state.hasMinLength;
  }

  void register(BuildContext context) {
    final String name = context.read<AuthCubit>().nameController.text;
    final String email = context.read<AuthCubit>().emailController.text;
    final String password = context.read<AuthCubit>().passwordController.text;
    final String confirmPassword =
        context.read<AuthCubit>().confirmPasswordController.text;

    final authCubit = context.read<AuthCubit>();

    if (name.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        authCubit.register(name, email, password);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss the keyboard
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_open,
                      size: 80,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "Let's Create an account for you",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    const SizedBox(height: 25),
                    const NameField(),
                    const SizedBox(height: 10),
                    const EmailField(),
                    const SizedBox(height: 10),
                    const PasswordField(),
                    const SizedBox(height: 10),
                    const ConfirmPasswordField(),
                    const SizedBox(height: 25),
                    RegisterButton(
                      formKey: formKey,
                      register: register,
                      allPasswordRulesPassed: allPasswordRulesPassed,
                    ),
                    const SizedBox(height: 25),
                    PasswordValidations(
                      hasLowerCase: context.watch<AuthCubit>().hasLowercase,
                      hasUpperCase: context.watch<AuthCubit>().hasUppercase,
                      hasSpecialCharacters:
                          context.watch<AuthCubit>().hasSpecialCharacters,
                      hasNumber: context.watch<AuthCubit>().hasNumber,
                      hasMinLength: context.watch<AuthCubit>().hasMinLength,
                    ),
                    const SizedBox(height: 25),
                    LoginNowRow(onLoginTap: onLoginTap),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
EOL

echo "📄 Created register_page.dart file successfully at $REGISTER_FILE"
echo "✅ Register template generated successfully."
