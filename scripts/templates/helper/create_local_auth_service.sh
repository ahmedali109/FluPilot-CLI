#!/bin/bash

function create_local_auth_service(){
 DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/services"
 LOCAL_AUTH_SERVICE_FILE="$DEST_DIR/local_auth_service.dart"
  # check if local_auth dependency is in pubspec.yaml
  PUBSPEC_FILE="${FLUTTER_PROJECT_DIR}/pubspec.yaml"
  if ! grep -q "local_auth:" "$PUBSPEC_FILE"; then
    echo "Adding local_auth dependency to pubspec.yaml..."
    (cd "$FLUTTER_PROJECT_DIR" && flutter pub add local_auth && flutter pub get)
    echo "✅ local_auth dependency added to pubspec.yaml."
  else
    echo "local_auth dependency already exists in pubspec.yaml."
  fi
  cat <<EOL > "$LOCAL_AUTH_SERVICE_FILE"
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:io';

class LocalAuthService {
  static final LocalAuthentication _auth = LocalAuthentication();

  /// Checks if device supports biometrics (Face ID or fingerprint)
  static Future<bool> canCheckBiometrics() async {
    try {
      return await _auth.canCheckBiometrics && await _auth.isDeviceSupported();
    } catch (e) {
      debugPrint('Biometric check error: \$e');
      return false;
    }
  }

  /// Authenticates the user using Face ID (iOS) or fingerprint (Android)
  static Future<bool> authenticate() async {
    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: Platform.isIOS
            ? 'Please authenticate with Face ID'
            : 'Please authenticate with your fingerprint',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      return didAuthenticate;
    } catch (e) {
      debugPrint('Authentication error: \$e');
      return false;
    }
  }
}
EOL

 echo "📄 Created local_auth_service.dart file successfully at $LOCAL_AUTH_SERVICE_FILE"
 echo "✅ Local Auth service template generated successfully."
}

export -f create_local_auth_service
