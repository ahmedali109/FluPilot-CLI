#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui"
FORGOT_PASSWORD_FILE="$DEST_DIR/forgot_password_page.dart"
PUBSPEC_FILE="$FLUTTER_PROJECT_DIR/pubspec.yaml"

function forgotPasswordLocalization(){
  cat <<EOL > "$FORGOT_PASSWORD_FILE"
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/helpers/app_regex.dart';
import '../logic/auth/auth_cubit.dart';
import 'widgets/forgot_password_header.dart';
import 'widgets/forgot_password_icon.dart';
import 'widgets/forgot_password_title.dart';
import 'widgets/forgot_password_content.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isLinkSent = false;

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animations
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack),
    );

    // Start animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "please_enter_your_email".tr();
    }
    if (!AppRegex.isEmailValid(value)) {
      return "please_enter_valid_email".tr();
    }
    return null;
  }

  Future<void> _sendResetLink() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final authCubit = context.read<AuthCubit>();
      final message = await authCubit.forgotPassword(
        _emailController.text.trim(),
      );
      if (message ==
          "Password reset email sent successfully check your inbox") {
        setState(() {
          _isLinkSent = true;
        });

        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("reset_link_sent_to"
                  .tr(namedArgs: {"email": _emailController.text.trim()})),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              duration: const Duration(seconds: 4),
            ),
          );
          // Clear the email field
          _emailController.clear();
          await Future.delayed(const Duration(seconds: 4));
          // Navigate back to the previous screen
          if (mounted) {
            Navigator.of(context).pop();
          }
        }
      } else {
        // Show error message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("email_not_found_message".tr()),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("email_not_found_message".tr()),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
                child: Column(
                  children: [
                    // Header with back button
                    ForgotPasswordHeader(
                      onBackPressed: () => Navigator.of(context).pop(),
                    ),

                    // Main content
                    Expanded(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Lock icon with gradient background
                              const ForgotPasswordIcon(),

                              const SizedBox(height: 40),

                              // Title and subtitle
                              const ForgotPasswordTitle(),

                              const SizedBox(height: 50),

                              // Content based on state
                              ForgotPasswordContent(
                                isLinkSent: _isLinkSent,
                                isLoading: _isLoading,
                                formKey: _formKey,
                                emailController: _emailController,
                                emailValidator: _validateEmail,
                                onSendResetLink: _sendResetLink,
                                onResendPressed: () {
                                  setState(() {
                                    _isLinkSent = false;
                                    _emailController.clear();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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


function forgotPasswordWithoutLocalization(){
  cat <<EOL > "$FORGOT_PASSWORD_FILE"
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helpers/app_regex.dart';
import '../logic/auth/auth_cubit.dart';
import 'widgets/forgot_password_header.dart';
import 'widgets/forgot_password_icon.dart';
import 'widgets/forgot_password_title.dart';
import 'widgets/forgot_password_content.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isLinkSent = false;

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animations
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack),
    );

    // Start animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "please enter your email";
    }
    if (!AppRegex.isEmailValid(value)) {
      return "please enter valid email";
    }
    return null;
  }

  Future<void> _sendResetLink() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final authCubit = context.read<AuthCubit>();
      final message = await authCubit.forgotPassword(
        _emailController.text.trim(),
      );
      if (message == "Password reset email sent successfully check your inbox") {
        setState(() {
          _isLinkSent = true;
        });

        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text("Reset link sent to \${_emailController.text.trim()}"),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              duration: const Duration(seconds: 4),
            ),
          );
          // Clear the email field
          _emailController.clear();
          await Future.delayed(const Duration(seconds: 4));
          // Navigate back to the previous screen
          if (mounted) {
            Navigator.of(context).pop();
          }
        }
      } else {
        // Show error message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("No account found with this email address. Please check your email or create a new account"),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("No account found with this email address. Please check your email or create a new account"),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
                child: Column(
                  children: [
                    // Header with back button
                    ForgotPasswordHeader(
                      onBackPressed: () => Navigator.of(context).pop(),
                    ),

                    // Main content
                    Expanded(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Lock icon with gradient background
                              const ForgotPasswordIcon(),

                              const SizedBox(height: 40),

                              // Title and subtitle
                              const ForgotPasswordTitle(),

                              const SizedBox(height: 50),

                              // Content based on state
                              ForgotPasswordContent(
                                isLinkSent: _isLinkSent,
                                isLoading: _isLoading,
                                formKey: _formKey,
                                emailController: _emailController,
                                emailValidator: _validateEmail,
                                onSendResetLink: _sendResetLink,
                                onResendPressed: () {
                                  setState(() {
                                    _isLinkSent = false;
                                    _emailController.clear();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
  echo "Generating forgot password page with localization support."
  forgotPasswordLocalization
else
  echo "❌ easy_localization is NOT present in pubspec.yaml"
  echo "Generating forgot password page without localization support."
  forgotPasswordWithoutLocalization
fi


echo "📄 Created forgot_password.dart file successfully at $FORGOT_PASSWORD_FILE"
echo "✅ Forgot Password template generated successfully."
