#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/logic/auth"
AUTH_CUBIT_FILE="$DEST_DIR/auth_cubit.dart"
cat <<EOL > "$AUTH_CUBIT_FILE"
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/app_regex.dart';
import '../../data/models/app_user.dart';
import '../../data/repo/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  bool registerPasswordObsecure = true;

  bool registerPasswordConfirmationObsecure = true;

  bool loginPasswordObsecure = true;

  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthState.initial()) {
    listenToPasswordChanges();
  }

  AppUser? get currentUser => _currentUser;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void toggleRegisterPasswordObsecure() {
    registerPasswordObsecure = !registerPasswordObsecure;
    emit(registerPasswordObsecure
        ? AuthState.registerPasswordObsecure()
        : AuthState.registerPasswordNotObsecure());
  }

  void toggleRegisterPasswordConfirmationObsecure() {
    registerPasswordConfirmationObsecure =
        !registerPasswordConfirmationObsecure;
    emit(registerPasswordConfirmationObsecure
        ? AuthState.registerPasswordConfirmationObsecure()
        : AuthState.registerPasswordConfirmationNotObsecure());
  }

  void toggleLoginPasswordObsecure() {
    loginPasswordObsecure = !loginPasswordObsecure;
    emit(loginPasswordObsecure
        ? AuthState.loginPasswordObsecure()
        : AuthState.loginPasswordNotObsecure());
  }

  void listenToPasswordChanges() {
    passwordController.addListener(_onPasswordChanged);
  }

  void _onPasswordChanged() {
    final text = passwordController.text;
    hasLowercase = AppRegex.hasLowerCase(text);
    hasUppercase = AppRegex.hasUpperCase(text);
    hasSpecialCharacters = AppRegex.hasSpecialCharacter(text);
    hasNumber = AppRegex.hasNumber(text);
    hasMinLength = AppRegex.hasMinLength(text);

    emit(AuthState.passwordValidations(
      hasLowercase: hasLowercase,
      hasUppercase: hasUppercase,
      hasSpecialCharacters: hasSpecialCharacters,
      hasNumber: hasNumber,
      hasMinLength: hasMinLength,
    ));
  }

  void checkAuth() async {
    emit(AuthState.loading());
    try {
      final AppUser? user = await authRepo.getCurrentUser();
      if (user != null) {
        _currentUser = user;
        emit(AuthState.authenticated(user));
      } else {
        emit(AuthState.unauthenticated());
      }
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> login(String email, String pw) async {
    try {
      emit(AuthState.loading());
      final user = await authRepo.loginWithEmailPassword(email, pw);
      if (user != null) {
        _currentUser = user;
        emit(AuthState.authenticated(user));
      } else {
        emit(AuthState.unauthenticated());
      }
    } catch (e) {
      emit(AuthState.error(e.toString()));
      emit(AuthState.unauthenticated());
    }
  }

  Future<void> register(String name, String email, String pw) async {
    try {
      emit(AuthState.loading());
      final user = await authRepo.registerWithEmailPassword(name, email, pw);
      if (user != null) {
        _currentUser = user;
        emit(AuthState.authenticated(user));
      } else {
        emit(AuthState.unauthenticated());
      }
    } catch (e) {
      emit(AuthState.error(e.toString()));
      emit(AuthState.unauthenticated());
    }
  }

  Future<void> logout() async {
    emit(AuthState.loading());
    await authRepo.logout();
    emit(AuthState.unauthenticated());
  }

  Future<String> forgotPassword(String email) async {
    try {
      final message = await authRepo.sendPasswordResetEmail(email);
      return message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> deleteAccount() async {
    try {
      emit(AuthState.loading());
      await authRepo.deleteAccount();
      emit(AuthState.unauthenticated());
    } catch (e) {
      emit(AuthState.error(e.toString()));
      emit(AuthState.unauthenticated());
    }
  }

  Future<void> signInWithApple() async {
    try {
      emit(AuthState.loading());
      final user = await authRepo.signInWithApple();
      if (user != null) {
        _currentUser = user;
        emit(AuthState.authenticated(user));
      } else {
        emit(AuthState.unauthenticated());
      }
    } catch (e) {
      emit(AuthState.error(e.toString()));
      emit(AuthState.unauthenticated());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(AuthState.loading());
      final user = await authRepo.signInWithGoogle();
      if (user != null) {
        _currentUser = user;
        emit(AuthState.authenticated(user));
      } else {
        emit(AuthState.unauthenticated());
      }
    } catch (e) {
      emit(AuthState.error(e.toString()));
      emit(AuthState.unauthenticated());
    }
  }
}
EOL

echo "📄 Created auth_cubit.dart file successfully at $AUTH_CUBIT_FILE"
echo "✅ Auth cubit template generated successfully."
