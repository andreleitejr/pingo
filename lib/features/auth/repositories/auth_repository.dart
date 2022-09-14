import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:pingo/models/user.dart';
import 'package:pingo/repositories/user_repository.dart';

class AuthRepository extends UserRepository {
  final _auth = auth.FirebaseAuth.instance;

  @override
  Future<void> save(User model, {String? documentId}) async {
    final user = await currentUser();

    if (user != null) {
      await super.save(model, documentId: user.uid);
    }
  }

  Future<void> create(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<auth.User?> currentUser() async {
    try {
      return _auth.currentUser;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
