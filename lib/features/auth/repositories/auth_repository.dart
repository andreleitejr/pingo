import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get/get.dart';
import 'package:pingo/constants/firebase_error.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/repositories/user_repository.dart';

enum AuthResult { emailAlreadyInUse, weakPassword, failed, success }

class AuthRepository extends UserRepository {
  final _auth = auth.FirebaseAuth.instance;

  Future<auth.User?> currentUser() async {
    try {
      return _auth.currentUser;
    } on auth.FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
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
        case FirebaseError.weakPassword:
          return AuthResult.weakPassword;
        default:
          return AuthResult.failed;
      }
    }
  }

  Future<AuthResult> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return AuthResult.success;
    } on auth.FirebaseAuthException catch (e) {
      return AuthResult.failed;
    }
  }

  @override
  Future<void> save(User model, {String? documentId}) async {
    try {
      final user = await currentUser();

      if (user != null) {
        model.uuid = user.uid;

        await super.save(model, documentId: user.uid);
        Get.put(model);
      }
    } catch (e) {
      print('Failed with error code: ${e}');
      print(e);
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
