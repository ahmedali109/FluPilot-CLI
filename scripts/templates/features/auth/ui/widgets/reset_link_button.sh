#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
RESET_LINK_BUTTON_FILE="$DEST_DIR/reset_link_button.dart"
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

echo "📄 Created reset_link_button.dart file successfully at $RESET_LINK_BUTTON_FILE"
echo "✅ Reset Link Button template generated successfully."
