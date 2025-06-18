#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui"
LOGIN_REGISTER_FILE="$DEST_DIR/login_or_register.dart"
cat <<EOL > "$LOGIN_REGISTER_FILE"
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/auth/auth_cubit.dart';
import 'login_page.dart';
import 'register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  void clearController(BuildContext context) {
    context.read<AuthCubit>().nameController.clear();
    context.read<AuthCubit>().emailController.clear();
    context.read<AuthCubit>().passwordController.clear();
    context.read<AuthCubit>().confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    clearController(context);
    if (showLoginPage) {
      return LoginPage(onRegisterTap: togglePages);
    } else {
      return RegisterPage(onLoginTap: togglePages);
    }
  }
}

EOL

echo "📄 Created login_or_register.dart file successfully at $LOGIN_REGISTER_FILE"
echo "✅ Login/Register template generated successfully."
