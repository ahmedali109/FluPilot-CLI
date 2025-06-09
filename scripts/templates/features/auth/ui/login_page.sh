#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui"
LOGIN_FILE="$DEST_DIR/login_page.dart"
PUBSPEC_FILE="$FLUTTER_PROJECT_DIR/pubspec.yaml"

function loginPageLocalization(){
  cat <<EOL > "$LOGIN_FILE"
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'forgot_password.dart';
import 'widgets/email_field.dart';
import 'widgets/forget_password_button.dart';
import 'widgets/my_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/auth/auth_cubit.dart';
import 'widgets/my_button.dart';
import 'widgets/password_field.dart';
import 'widgets/register_now_row.dart';
import 'widgets/social_login_row.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, this.onRegisterTap});

  final VoidCallback? onRegisterTap;
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void login(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    final String email = authCubit.emailController.text;
    final String password = authCubit.passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      authCubit.login(email, password);
    }
  }

  void openforgetPassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("forgot_password".tr()),
        content: MyTextField(
          controller: context.read<AuthCubit>().emailController,
          hintText: "email".tr(),
          obscureText: false,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("cancel".tr()),
          ),
          TextButton(
            onPressed: () async {
              String message = await context.read<AuthCubit>().forgotPassword(
                  context.read<AuthCubit>().emailController.text);
              if (message ==
                  "Password reset email sent successfully check your inbox") {
                if (context.mounted) {
                  Navigator.of(context).pop();
                  context.read<AuthCubit>().emailController.clear();
                }
              }
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              }
            },
            child: Text("reset_password".tr()),
          ),
        ],
      ),
    );
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
                      "app_title".tr(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    const SizedBox(height: 25),
                    const EmailField(),
                    const SizedBox(height: 10),
                    const PasswordField(),
                    const SizedBox(height: 10),
                    ForgotPasswordButton(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    MyButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          login(context);
                        }
                      },
                      text: "login".tr(),
                    ),
                    const SizedBox(height: 25),
                    const SocialLoginRow(),
                    const SizedBox(height: 10),
                    RegisterNowRow(onRegisterTap: onRegisterTap),
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

}

function loginPageWithoutLocalization(){
  cat <<EOL > "$LOGIN_FILE"
import 'package:flutter/material.dart';
import 'widgets/email_field.dart';
import 'forgot_password.dart';
import 'widgets/forget_password_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/auth/auth_cubit.dart';
import 'widgets/my_button.dart';
import 'widgets/password_field.dart';
import 'widgets/register_now_row.dart';
import 'widgets/social_login_row.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, this.onRegisterTap});

  final VoidCallback? onRegisterTap;
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void login(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    final String email = authCubit.emailController.text;
    final String password = authCubit.passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      authCubit.login(email, password);
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
                      "B U I L D   L A U N C H ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    const SizedBox(height: 25),
                    const EmailField(),
                    const SizedBox(height: 10),
                    const PasswordField(),
                    const SizedBox(height: 10),
                    ForgotPasswordButton(
                       onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    MyButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          login(context);
                        }
                      },
                      text: "L O G I N",
                    ),
                    const SizedBox(height: 25),
                    const SocialLoginRow(),
                    const SizedBox(height: 10),
                    RegisterNowRow(onRegisterTap: onRegisterTap),
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
}


if grep -q "easy_localization:" "$PUBSPEC_FILE"; then
  echo "✅ easy_localization is present in pubspec.yaml"
  echo "Generating login page with localization support."
  loginPageLocalization
else
  echo "❌ easy_localization is NOT present in pubspec.yaml"
  echo "Generating login page without localization support."
  loginPageWithoutLocalization
fi

echo "📄 Created login_page.dart file successfully at $LOGIN_FILE"
echo "✅ Login template generated successfully."
