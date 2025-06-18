#!/bin/bash

function connectivity_plus(){
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
  echo "🛠️ Generating connectivity_plus template in $DEST_DIR"

  if ! grep -q "connectivity_plus:" pubspec.yaml; then
    echo "❌ connectivity_plus not found in pubspec.yaml. Please add it under dependencies."
    echo "Example:"
    echo "dependencies:"
    echo "  connectivity_plus: latest_version"
    exit 1
  fi

  echo "✅ connectivity_plus found in pubspec.yaml."
  echo "📂 Creating connectivity_service.dart in $DEST_DIR/lib/core/helpers..."

  touch "$DEST_DIR/lib/core/helpers/connectivity_service.dart" || {
    echo "❌ Failed to create connectivity_service.dart"
    exit 1
  }

  create_connectivity_service_content() {
    cat <<EOF > "$DEST_DIR/lib/core/helpers/connectivity_service.dart"

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Future<List<ConnectivityResult>> get connectivityResult async =>
      await _connectivity.checkConnectivity();

  Future<bool> get isConnected async => !(await _connectivity.checkConnectivity()).contains(ConnectivityResult.none);

  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;

  // Optional: Check if connected via WiFi, Mobile, or VPN
  Future<String> get connectionType async {
    final results = await _connectivity.checkConnectivity();
    if (results.contains(ConnectivityResult.wifi)) {
      return 'WiFi';
    } else if (results.contains(ConnectivityResult.mobile)) {
      return 'Mobile';
    } else if (results.contains(ConnectivityResult.vpn)) {
      return 'VPN';
    } else if (results.contains(ConnectivityResult.ethernet)) {
      return 'Ethernet';
    } else {
      return 'None';
    }
  }

  @override
  bool operator ==(covariant ConnectivityService other) {
    if (identical(this, other)) return true;

    return
      other.connectivityResult == connectivityResult;
  }

  @override
  int get hashCode => ConnectivityResult.none.hashCode;
}

EOF
}

  create_connectivity_service_content || {
      echo "❌ Failed to write to connectivity_service.dart"
      exit 1
  }
  echo "📄 Created connectivity_service.dart file successfully at $DEST_DIR/lib/core/helpers/connectivity_service.dart"
  echo "✅ Connectivity service template generated successfully."
  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  echo
  cd - >/dev/null || exit 1
}
