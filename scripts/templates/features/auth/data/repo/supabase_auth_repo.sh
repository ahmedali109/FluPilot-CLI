#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/data/repo"
SUPABASE_AUTH_REPO_FILE="$DEST_DIR/supabase_auth_repo.dart"
cat <<EOL > "$SUPABASE_AUTH_REPO_FILE"
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constants/strings.dart';
import '../models/app_user.dart';
import 'auth_repo.dart';

class SupabaseAuthRepo implements AuthRepo {
  static final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<void> deleteAccount() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      await _supabase.rpc('delete_user', params: {'user_id': user.id});
      await _supabase.auth.signOut();
    }
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;
    return AppUser(uid: user.id, email: user.email ?? '');
  }

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    final response = await _supabase.auth
        .signInWithPassword(email: email, password: password);
    return response.user != null
        ? AppUser(uid: response.user!.id, email: response.user!.email ?? '')
        : null;
  }

  @override
  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
      String name, String email, String password) async {
    final response =
        await _supabase.auth.signUp(email: email, password: password);
    return response.user != null
        ? AppUser(uid: response.user!.id, email: response.user!.email ?? '')
        : null;
  }

  @override
  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
      return "Password reset email sent successfully. Check your inbox.";
    } catch (e) {
      return "An error occurred while sending password reset email: $e";
    }
  }

  @override
  Future<AppUser?> signInWithApple() async {
    throw UnimplementedError('Apple Sign-In is not implemented yet.');
  }

  @override
  Future<AppUser?> signInWithGoogle() async {
    const webClientId = AppStrings.webClientId;
    const iosClientId = AppStrings.iosClientId;

    if (webClientId.isEmpty || iosClientId.isEmpty) {
      throw 'Please provide your web and iOS client IDs for Google Sign-In.';
    }
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final gUser = await googleSignIn.signIn();
    if (gUser == null) return null; // User cancelled the sign-in
    final googleAuth = await gUser.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;
    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }
    await _supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
    final user = _supabase.auth.currentUser;
    return user != null ? AppUser(uid: user.id, email: user.email ?? '') : null;
  }
}
EOL

echo "📄 Created supabase_auth_repo.dart file successfully at $SUPABASE_AUTH_REPO_FILE"
echo "✅ Supabase auth repo template generated successfully."
