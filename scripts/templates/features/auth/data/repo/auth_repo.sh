#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/data/repo"
AUTH_REPO_FILE="$DEST_DIR/auth_repo.dart"
cat <<EOL > "$AUTH_REPO_FILE"
import '../models/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> getCurrentUser();
  Future<AppUser?> registerWithEmailPassword(String name , String email, String password);
  Future<AppUser?> loginWithEmailPassword(String email , String password);
  Future<String> sendPasswordResetEmail(String email);
  Future<void> deleteAccount();
  Future<void> logout();
  Future<AppUser?> signInWithGoogle();
  Future<AppUser?> signInWithApple();
}
EOL

echo "📄 Created auth_repo.dart file successfully at $AUTH_REPO_FILE"
echo "✅ Auth repo template generated successfully."
