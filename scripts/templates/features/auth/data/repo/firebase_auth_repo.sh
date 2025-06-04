#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/data/repo"
FIREBASE_AUTH_REPO_FILE="$DEST_DIR/firebase_auth_repo.dart"
cat <<EOL > "$FIREBASE_AUTH_REPO_FILE"
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../models/app_user.dart';
import 'auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AppUser?> getCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;

    if (firebaseUser == null) return null;

    return AppUser(uid: firebaseUser.uid, email: firebaseUser.email!);
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      AppUser user = AppUser(uid: userCredential.user!.uid, email: email);
      return user;
    } catch (e) {
      throw Exception('Registration failed: \$e');
    }
  }

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      AppUser user = AppUser(uid: userCredential.user!.uid, email: email);
      return user;
    } catch (e) {
      throw Exception('Login failed: \$e');
    }
  }

  @override
  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return "Password reset email sent successfully check your inbox";
    } catch (e) {
      return "An error occured while sending password reset email: \$e";
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) throw Exception('No user is currently logged in');
      await user.delete();
      await logout();
    } catch (e) {
      throw Exception('Account deletion failed: \$e');
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.fullName,
          AppleIDAuthorizationScopes.email,
        ],
      );
      final oAuthCredential = OAuthProvider("apple.com").credential(
        accessToken: appleCredential.authorizationCode,
        idToken: appleCredential.identityToken,
      );
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(oAuthCredential);

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) return null;
      return AppUser(uid: firebaseUser.uid, email: firebaseUser.email ?? '');
    } catch (e) {
      throw Exception('Sign in with Apple failed: \$e');
    }
  }

  @override
  Future<AppUser?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) return null; // User cancelled the sign-in
      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      final firebaseUser = userCredential.user;
      if (firebaseUser == null) return null;
      return AppUser(uid: firebaseUser.uid, email: firebaseUser.email ?? '');
    } catch (e) {
      throw Exception('Sign in with Google failed: \$e');
    }
  }
}
EOL

echo "📄 Created firebase_auth_repo.dart file successfully at $FIREBASE_AUTH_REPO_FILE"
echo "✅ Firebase auth repo template generated successfully."
