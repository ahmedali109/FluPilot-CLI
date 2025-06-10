#!/bin/bash

function create_local_auth_service(){
 DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/services"
 LOCAL_AUTH_SERVICE_FILE="$DEST_DIR/local_auth_service.dart"
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
