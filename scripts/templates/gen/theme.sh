#!/usr/bin/env bash

function themeConfigure(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}"

  if [ -z "$DEST_DIR" ]; then
    echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
    exit 1
  fi

  mkdir -p "$DEST_DIR/lib/core/theme" || {
    echo "❌ Failed to create directory $DEST_DIR/lib/core/theme"
    exit 1
  }

  echo "📂 Created directory $DEST_DIR/lib/core/theme"
  cd "$DEST_DIR" || exit 1
  echo "🛠️ Generating extensions template in $DEST_DIR"

  echo "📂 Creating light_mode.dart in $DEST_DIR/lib/core/theme..."
  touch "$DEST_DIR/lib/core/theme/light_mode.dart" || {
    echo "❌ Failed to create light_mode.dart"
    exit 1
  }

  echo "📂 Creating dark_mode.dart in $DEST_DIR/lib/core/theme..."
  touch "$DEST_DIR/lib/core/theme/dark_mode.dart" || {
    echo "❌ Failed to create dark_mode.dart"
    exit 1
  }

function create_light_mode() {
  cat <<EOL > "$DEST_DIR/lib/core/theme/light_mode.dart"
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Colors.black,
    secondary: Colors.grey.shade200,
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade900,
  ),
  scaffoldBackgroundColor: Colors.grey.shade300,
);

EOL
    echo "📄 light_mode.dart created successfully."
}

  create_light_mode || {
    echo "❌ Failed to create light_mode.dart"
    exit 1
  }
  echo "✅ light_mode.dart created successfully in $DEST_DIR/lib/core/theme/light_mode.dart"

function create_dark_mode() {
  cat <<EOL > "$DEST_DIR/lib/core/theme/dark_mode.dart"
import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.white,
    secondary: Color.fromARGB(255, 53, 53, 53),
    tertiary: Color.fromARGB(255, 25, 25, 25),
    inversePrimary: Colors.grey.shade300,
  ),
  scaffoldBackgroundColor: Colors.grey.shade900,
);

EOL
    echo "📄 dark_mode.dart created successfully."
}
  create_dark_mode || {
    echo "❌ Failed to create dark_mode.dart"
    exit 1
  }
  echo "✅ dark_mode.dart created successfully in $DEST_DIR/lib/core/theme/dark_mode.dart"

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
