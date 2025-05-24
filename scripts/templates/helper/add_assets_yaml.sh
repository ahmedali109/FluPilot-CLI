#!/bin/bash

# Cross-platform script to ensure assets/images/ and assets/icons/ are listed under flutter: in pubspec.yaml

PUBSPEC_FILE="$FLUTTER_PROJECT_DIR/pubspec.yaml"

# Check if assets section already exists under flutter:
if grep -qE '^\s*assets:\s*$' "$PUBSPEC_FILE"; then
  # Remove any existing assets/images/ or assets/icons/ lines to avoid duplicates
  if [[ "$(uname -s)" == "Darwin" ]]; then
    sed -i '' '/- assets\/images\//d' "$PUBSPEC_FILE"
    sed -i '' '/- assets\/icons\//d' "$PUBSPEC_FILE"
  else
    sed -i '/- assets\/images\//d' "$PUBSPEC_FILE"
    sed -i '/- assets\/icons\//d' "$PUBSPEC_FILE"
  fi
  # Add the correct assets section after assets:
  awk 'BEGIN{a=0} /^\s*assets:\s*$/ && !a {print; print "    - assets/images/\n    - assets/icons/"; a=1; next} 1' "$PUBSPEC_FILE" > "$PUBSPEC_FILE.tmp" && mv "$PUBSPEC_FILE.tmp" "$PUBSPEC_FILE"
else
  # Insert assets section under flutter:
  awk '/^flutter:/ && !x {print; x=1; next} 1' "$PUBSPEC_FILE" | \
  awk '/^  uses-material-design:/ && !y {print; print "  assets:\n    - assets/images/\n    - assets/icons/"; y=1; next} 1' > "$PUBSPEC_FILE.tmp" && mv "$PUBSPEC_FILE.tmp" "$PUBSPEC_FILE"
fi

echo "✅ pubspec.yaml now contains the correct assets section under flutter:"
