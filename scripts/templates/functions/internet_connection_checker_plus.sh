#!/bin/bash

function internet_connection_checker_plus(){
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
  echo "🛠️ Generating internet_connection_checker_plus template in $DEST_DIR"

  if ! grep -q "internet_connection_checker_plus:" pubspec.yaml; then
    echo "❌ internet_connection_checker_plus not found in pubspec.yaml. Please add it under dependencies."
    echo "Example:"
    echo "dependencies:"
    echo "  internet_connection_checker_plus: latest_version"
    exit 1
  fi

  echo "✅ internet_connection_checker_plus found in pubspec.yaml."
  echo "📂 Creating internet_connection_checker_plus_service.dart in $DEST_DIR/lib/core/helpers..."

  touch "$DEST_DIR/lib/core/helpers/internet_connection_checker_plus_service.dart" || {
    echo "❌ Failed to create internet_connection_checker_plus_service.dart"
    exit 1
  }

  create_internet_connection_checker_plus_service_content() {
    cat <<EOF > "$DEST_DIR/lib/core/helpers/internet_connection_checker_plus_service.dart"
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetConnectionCheckerPlusService {
  InternetConnectionCheckerPlusService._();

  static Future<bool> get isConnected async => await InternetConnection().hasInternetAccess;

  static Stream<bool> get onStatusChange =>
      InternetConnection().onStatusChange.map((status) => status == InternetStatus.connected);
}
EOF
}
  create_internet_connection_checker_plus_service_content || {
      echo "❌ Failed to write to internet_connection_checker_plus_service.dart"
      exit 1
  }
  echo "📄 Created internet_connection_checker_plus_service.dart file successfully at $DEST_DIR/lib/core/helpers/internet_connection_checker_plus_service.dart"
  echo "✅ Internet connection checker plus service template generated successfully."
  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
