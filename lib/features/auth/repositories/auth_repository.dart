import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/firebase_error.dart';
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
}

class AuthRepository extends UserRepository {
  final _auth = auth.FirebaseAuth.instance;

  Future<auth.User?> currentUser() async {
    try {
      return _auth.currentUser;
    } on auth.FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
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
      switch (e.code) {
        case FirebaseError.emailAlreadyInUse:
          return AuthResult.emailAlreadyInUse;
        case FirebaseError.wrongPassword:
          return AuthResult.wrongPassword;
        default:
          return AuthResult.failed;
      }
    }
  }

  Future<AuthResult> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return _getUser(result);
    } on auth.FirebaseAuthException catch (e) {
      switch (e.code) {
        case FirebaseError.userNotFound:
          return AuthResult.userNotFound;
        case FirebaseError.wrongPassword:
          return AuthResult.wrongPassword;
        case FirebaseError.tooManyRequests:
          return AuthResult.tooManyRequests;
        default:
          return AuthResult.failed;
      }
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
    } catch (e) {
      return AuthResult.failed;
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
    } catch (e) {
      debugPrint('Failed with error code: $e');
      return AuthResult.failed;
    }
  }

  Future<void> signOut() async {
    try {
      _auth.signOut();
    } on auth.FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }
}
