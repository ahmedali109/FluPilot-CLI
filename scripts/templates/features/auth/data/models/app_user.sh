#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/data/models"
APP_USER_FILE="$DEST_DIR/app_user.dart"
cat <<EOL > "$APP_USER_FILE"
class AppUser {
  final String uid;
  final String email;

  AppUser({
    required this.uid,
    required this.email,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'],
      email: json['email'],
    );
  }
}
EOL

echo "📄 Created app_user.dart file successfully at $APP_USER_FILE"
echo "✅ App user template generated successfully."
