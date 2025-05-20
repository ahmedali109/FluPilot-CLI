#!/bin/bash

if [ -n "$FLUTTER_PROJECT_DIR" ]; then
  cd "$FLUTTER_PROJECT_DIR" || { echo "❌ Failed to enter project directory"; exit 1; }
fi

# Check for selected packages
if [ ${#SELECTED_PACKAGES[@]} -eq 0 ]; then
  echo "⚠️ No packages selected. Skipping package install and template generation."
else
  echo "📦 Adding selected packages..."
  for PACKAGE in "${SELECTED_PACKAGES[@]}"; do
    echo "  ➕ Adding $PACKAGE..."
    flutter pub add "$PACKAGE"
  done
fi

# Return to original directory (important for subsequent scripts)
cd - >/dev/null
