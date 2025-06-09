#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
RESET_LINK_BUTTON_FILE="$DEST_DIR/reset_link_button.dart"
PUBSPEC_FILE="$FLUTTER_PROJECT_DIR/pubspec.yaml"

function resetLinkButtonLocalization(){
  cat <<EOL > "$RESET_LINK_BUTTON_FILE"
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ResetLinkButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const ResetLinkButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.tertiary,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              )
            : Text(
                "send_reset_link".tr(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}

EOL
}


function resetLinkButtonWithoutLocalization(){
  cat <<EOL > "$RESET_LINK_BUTTON_FILE"
import 'package:flutter/material.dart';

class ResetLinkButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const ResetLinkButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.tertiary,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              )
            : const Text(
                "Send Reset Link",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
EOL
}

if grep -q "easy_localization:" "$PUBSPEC_FILE"; then
  echo "✅ easy_localization is present in pubspec.yaml"
  echo "Generating reset link button with localization support."
  resetLinkButtonLocalization
else
  echo "❌ easy_localization is NOT present in pubspec.yaml"
  echo "Generating reset link button without localization support."
  resetLinkButtonWithoutLocalization
fi

echo "📄 Created reset_link_button.dart file successfully at $RESET_LINK_BUTTON_FILE"
echo "✅ Reset Link Button template generated successfully."
