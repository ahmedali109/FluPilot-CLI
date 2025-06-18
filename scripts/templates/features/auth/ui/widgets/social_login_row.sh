#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
SOCIAL_LOGIN_ROW_FILE="$DEST_DIR/social_login_row.dart"
PUBSPEC_FILE="$FLUTTER_PROJECT_DIR/pubspec.yaml"

function socialLoginRowLocalization(){
  cat <<EOL > "$SOCIAL_LOGIN_ROW_FILE"
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../logic/auth/auth_cubit.dart';
import 'my_apple_sign_in_button.dart';
import 'my_google_sign_in_button.dart';

class SocialLoginRow extends StatelessWidget {
  const SocialLoginRow({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(
                color: Theme.of(context).colorScheme.primary,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "or_continue_with".tr(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: Theme.of(context).colorScheme.primary,
                thickness: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyAppleSignInButton(
              onPressed: () async {
                context.read<AuthCubit>().signInWithApple();
              },
            ),
            const SizedBox(width: 10),
            MyGoogleSignInButton(
              onPressed: () async {
                context.read<AuthCubit>().signInWithGoogle();
              },
            ),
          ],
        ),
      ],
    );
  }
}
EOL
}


function socialLoginRowWithoutLocalization(){
  cat <<EOL > "$SOCIAL_LOGIN_ROW_FILE"
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/auth/auth_cubit.dart';
import 'my_apple_sign_in_button.dart';
import 'my_google_sign_in_button.dart';

class SocialLoginRow extends StatelessWidget {
  const SocialLoginRow({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(
                color: Theme.of(context).colorScheme.primary,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "or continue with",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: Theme.of(context).colorScheme.primary,
                thickness: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyAppleSignInButton(
              onPressed: () async {
                context.read<AuthCubit>().signInWithApple();
              },
            ),
            const SizedBox(width: 10),
            MyGoogleSignInButton(
              onPressed: () async {
                context.read<AuthCubit>().signInWithGoogle();
              },
            ),
          ],
        ),
      ],
    );
  }
}
EOL
}

if grep -q "easy_localization:" "$PUBSPEC_FILE"; then
  echo "✅ easy_localization is present in pubspec.yaml"
  echo "Generating social login row with localization support."
  socialLoginRowLocalization
else
  echo "❌ easy_localization is NOT present in pubspec.yaml"
  echo "Generating social login row without localization support."
  socialLoginRowWithoutLocalization
fi

echo "📄 Created social_login_row.dart file successfully at $SOCIAL_LOGIN_ROW_FILE"
echo "✅ Social Login Row template generated successfully."
