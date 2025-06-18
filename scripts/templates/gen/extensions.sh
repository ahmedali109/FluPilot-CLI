#!/bin/bash

function extensions(){
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
  echo "🛠️ Generating extensions template in $DEST_DIR"

  echo "📂 Creating extensions.dart in $DEST_DIR/lib/core/helpers..."
  touch "$DEST_DIR/lib/core/helpers/extensions.dart" || {
    echo "❌ Failed to create extensions.dart"
    exit 1
  }

  function create_extensions() {
    cat <<EOL > "$DEST_DIR/lib/core/helpers/extensions.dart"
import 'package:flutter/widgets.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
}

extension ListExtension<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}
EOL
    echo "📄 extensions.dart created successfully."
  }
  create_extensions || {
    echo "❌ Failed to create extensions.dart"
    exit 1
  }
  echo "✅ extensions.dart created successfully in $DEST_DIR/lib/core/helpers/extensions.dart"

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
