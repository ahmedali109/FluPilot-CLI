#!/bin/bash

function spacing(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}"

  if [ -z "$DEST_DIR" ]; then
    echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
    exit 1
  fi

  mkdir -p "$DEST_DIR/lib/core/helpers" || {
    echo "❌ Failed to create directory $DEST_DIR/lib/core/helpers"
    exit 1
  }

  echo "📂 Created directory $DEST_DIR/lib/core/helpers"
  cd "$DEST_DIR" || exit 1
  echo "🛠️ Generating spacing template in $DEST_DIR"

  echo "📂 Creating spacing.dart in $DEST_DIR/lib/core/helpers..."
  touch "$DEST_DIR/lib/core/helpers/spacing.dart" || {
    echo "❌ Failed to create spacing.dart"
    exit 1
  }

  function create_spacing() {
    cat <<EOL > "$DEST_DIR/lib/core/helpers/spacing.dart"
import 'package:flutter/material.dart';

SizedBox verticalSpace(double height) => SizedBox(height: height);
SizedBox horizontalSpace(double width) => SizedBox(width: width);

sealed class Spacing {
  /// Small spacing of 8.0 pixels.
  static const double small = 8.0;
  /// Medium spacing of 16.0 pixels.
  static const double medium = 16.0;
  /// Large spacing of 32.0 pixels.
  static const double large = 32.0;
  /// Extra large spacing of 64.0 pixels.
  static const double xLarge = 64.0;
  /// Extra extra large spacing of 128.0 pixels.
  static const double xxLarge = 128.0;
}

class VerticalSpacing extends Spacing{
  /// small spacing of 8.0 pixels.
  static const small = SizedBox(height: Spacing.small);
  /// medium spacing of 16.0 pixels.
  static const medium = SizedBox(height: Spacing.medium);
  /// large spacing of 32.0 pixels.
  static const large = SizedBox(height: Spacing.large);
  /// extra large spacing of 64.0 pixels.
  static const xLarge = SizedBox(height: Spacing.xLarge);
  /// extra extra large spacing of 128.0 pixels.
  static const xxLarge = SizedBox(height: Spacing.xxLarge);
}

class HorizontalSpacing extends Spacing {
  /// small spacing of 8.0 pixels.
  static const small = SizedBox(width: Spacing.small);
  /// medium spacing of 16.0 pixels.
  static const medium = SizedBox(width: Spacing.medium);
  /// large spacing of 32.0 pixels.
  static const large = SizedBox(width: Spacing.large);
  /// extra large spacing of 64.0 pixels.
  static const xLarge = SizedBox(width: Spacing.xLarge);
  /// extra extra large spacing of 128.0 pixels.
  static const xxLarge = SizedBox(width: Spacing.xxLarge);
}

class PaddingAllSpacing extends Spacing {
  /// small padding of 8.0 pixels.
  static const EdgeInsets smallPadding = EdgeInsets.all(Spacing.small);
  /// medium padding of 16.0 pixels.
  static const EdgeInsets mediumPadding = EdgeInsets.all(Spacing.medium);
  /// large padding of 32.0 pixels.
  static const EdgeInsets largePadding = EdgeInsets.all(Spacing.large);
  /// extra large padding of 64.0 pixels.
  static const EdgeInsets xLargePadding = EdgeInsets.all(Spacing.xLarge);
  /// extra extra large padding of 128.0 pixels.
  static const EdgeInsets xxLargePadding = EdgeInsets.all(Spacing.xxLarge);
}

class MarginAllSpacing extends Spacing {
  /// small margin of 8.0 pixels.
  static const EdgeInsets smallMargin = EdgeInsets.all(Spacing.small);
  /// medium margin of 16.0 pixels.
  static const EdgeInsets mediumMargin = EdgeInsets.all(Spacing.medium);
  /// large margin of 32.0 pixels.
  static const EdgeInsets largeMargin = EdgeInsets.all(Spacing.large);
  /// extra large margin of 64.0 pixels.
  static const EdgeInsets xLargeMargin = EdgeInsets.all(Spacing.xLarge);
  /// extra extra large margin of 128.0 pixels.
  static const EdgeInsets xxLargeMargin = EdgeInsets.all(Spacing.xxLarge);
}

EOL
}
  echo "📄 spacing.dart created successfully."
  create_spacing || {
    echo "❌ Failed to create spacing.dart"
    exit 1
  }
  echo "✅ spacing.dart created successfully in $DEST_DIR/lib/core/helpers/spacing.dart"

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
