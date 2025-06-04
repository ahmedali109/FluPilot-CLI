#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
SOCIAL_LOGIN_ROW_FILE="$DEST_DIR/social_login_row.dart"
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

echo "📄 Created social_login_row.dart file successfully at $SOCIAL_LOGIN_ROW_FILE"
echo "✅ Social Login Row template generated successfully."
