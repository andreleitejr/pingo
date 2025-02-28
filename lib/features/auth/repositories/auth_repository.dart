import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/repositories/user_repository.dart';

enum AuthResult {
  success,
  failed,
  emailAlreadyInUse,
  weakPassword,
  wrongPassword,
  userNotFound,
  userNotFoundInDatabase,
  tooManyRequests,
  required,
}

class AuthRepository extends UserRepository {
  final _auth = auth.FirebaseAuth.instance;

  Future<auth.User?> currentUser() async {
    try {
      return _auth.currentUser;
    } on auth.FirebaseAuthException catch (e) {
      debugPrint('AuthRepository | Current User Error: $e');
      return null;
    }
  }

  Future<AuthResult> signUpWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _auth.currentUser?.updateDisplayName(name);

      return AuthResult.success;
    } on auth.FirebaseAuthException catch (e) {
      debugPrint('AuthRepository | Sign Up With E-mail and Password: $e');
      return e.code.authResultError;
    }
  }

  Future<AuthResult> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return getDataBaseUser(result);
    } on auth.FirebaseAuthException catch (e) {
      debugPrint('AuthRepository | Sign In With E-mail and Password Error: $e');
      return e.code.authResultError;
    }
  }

  Future<AuthResult> getDataBaseUser(auth.UserCredential credential) async {
    try {
      final user = await super.get(credential.user!.uid);
      if (user != null) {
        Get.put(user);
        return AuthResult.success;
      }
      return AuthResult.failed;
    } on FirebaseException catch (e) {
      debugPrint('AuthRepository | Get User Error: $e');
      return e.code.authResultError;
    }
  }

  @override
  Future<AuthResult> save(User model, {String? documentId}) async {
    try {
      final user = await currentUser();

      if (user != null) {
        model.uuid = user.uid;

        await super.save(model, documentId: user.uid).then(
          (_) {
            Get.put(model);
          },
        );

        return AuthResult.success;
      }

      return AuthResult.failed;
    } on FirebaseException catch (e) {
      debugPrint('AuthRepository | Save Error: $e');
      return e.code.authResultError;
    }
  }

  Future<AuthResult> signOut() async {
    try {
      await _auth.signOut();
      return AuthResult.success;
    } on auth.FirebaseAuthException catch (e) {
      debugPrint('AuthRepository | Sign Out Error: $e');
      return AuthResult.failed;
    }
  }

  Future<AuthResult> setLanguageCode(String code) async {
    try {
      await _auth.setLanguageCode(code);
      return AuthResult.success;
    } on auth.FirebaseAuthException catch (e) {
      debugPrint('AuthRepository | Language Code: $e');
      return AuthResult.failed;
    }
  }

  Future<AuthResult> recoverPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return AuthResult.success;
    } on auth.FirebaseAuthException catch (e) {
      debugPrint('AuthRepository | Recover Error: $e');
      return AuthResult.failed;
    }
  }
}
