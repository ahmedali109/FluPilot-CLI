#!/bin/bash

function create_custom_pull_to_refresh(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/widgets"
  PULL_TO_REFRESH_FILE="$DEST_DIR/custom_pull_to_refresh.dart"
  # check if liquid_pull_to_refresh dependency is in pubspec.yaml
  PUBSPEC_FILE="${FLUTTER_PROJECT_DIR}/pubspec.yaml"
  if ! grep -q "liquid_pull_to_refresh:" "$PUBSPEC_FILE"; then
    echo "Adding liquid_pull_to_refresh dependency to pubspec.yaml..."
    (cd "$FLUTTER_PROJECT_DIR" && flutter pub add liquid_pull_to_refresh && flutter pub get)
    echo "✅ liquid_pull_to_refresh dependency added to pubspec.yaml."
  else
    echo "liquid_pull_to_refresh dependency already exists in pubspec.yaml."
  fi
  cat <<EOL > "$PULL_TO_REFRESH_FILE"
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class PullToRefresh extends StatelessWidget {
  const PullToRefresh({
    super.key,
    required this.child,
    required this.onRefresh,
  });
  final Widget child;
  final Future<void> Function() onRefresh;
  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      animSpeedFactor: 3,
      showChildOpacityTransition: false,
      color: Colors.amberAccent,
      height: MediaQuery.of(context).size.height * 0.15,
      backgroundColor: Colors.red,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
EOL
  echo "📄 Created custom_pull_to_refresh.dart file successfully at $PULL_TO_REFRESH_FILE"
  echo "✅ Custom pull_to_refresh template generated successfully."
}

export -f create_custom_pull_to_refresh
