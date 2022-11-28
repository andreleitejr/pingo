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
      return e.code.resultError;
    }
  }

  Future<AuthResult> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return _getUser(result);
    } on auth.FirebaseAuthException catch (e) {
      return e.code.resultError;
    }
  }

  Future<AuthResult> _getUser(auth.UserCredential credential) async {
    try {
      final user = await super.get(credential.user!.uid);
      if (user != null) {
        Get.put(user);
        return AuthResult.success;
      }
      return AuthResult.failed;
    } on FirebaseException catch (e) {
      return e.code.resultError;
    }
  }

  @override
  Future<AuthResult> save(User model, {String? documentId}) async {
    try {
      final user = await currentUser();

      if (user != null) {
        model.uuid = user.uid;

        await super.save(model, documentId: user.uid).then((_) {
          Get.put(model);
        });

        return AuthResult.success;
      }

      return AuthResult.failed;
    } on FirebaseException catch (e) {
      return e.code.resultError;
    }
  }

  Future<void> signOut() async {
    try {
      _auth.signOut();
    } on auth.FirebaseAuthException catch (e) {
      debugPrint('AuthRepository | Sign Out Error: $e');
    }
  }
}
