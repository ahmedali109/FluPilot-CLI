#!/bin/bash

function internet_connection_checker(){
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
  echo "🛠️ Generating internet_connection_checker template in $DEST_DIR"

  if ! grep -q "internet_connection_checker:" pubspec.yaml; then
    echo "❌ internet_connection_checker not found in pubspec.yaml. Please add it under dependencies."
    echo "Example:"
    echo "dependencies:"
    echo "  internet_connection_checker: latest_version"
    exit 1
  fi

  echo "✅ internet_connection_checker found in pubspec.yaml."
  echo "📂 Creating internet_connection_service.dart in $DEST_DIR/lib/core/helpers..."

  touch "$DEST_DIR/lib/core/helpers/internet_connection_service.dart" || {
    echo "❌ Failed to create internet_connection_service.dart"
    exit 1
  }

  create_internet_connection_service_content() {
    cat <<EOF > "$DEST_DIR/lib/core/helpers/internet_connection_service.dart"
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectionService {
  InternetConnectionService._();

  static Future<bool> get isConnected async => await InternetConnectionChecker.instance.hasConnection;

  static Stream<bool> get onStatusChange =>
      InternetConnectionChecker
      .instance
      .onStatusChange.map((status) => status == InternetConnectionStatus.connected);
}

EOF
}

  create_internet_connection_service_content || {
      echo "❌ Failed to write to internet_connection_service.dart"
      exit 1
  }
  echo "📄 Created internet_connection_service.dart file successfully at $DEST_DIR/lib/core/helpers/internet_connection_service.dart"
  echo "✅ Internet connection service template generated successfully."
  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
