import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pingo/main.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/repositories/user_repository.dart';

class LandingController extends GetxController {
  LandingController() {
    onReady();
  }

  final repository = UserRepository();

  @override
  void onReady() => users.bindStream(repository.read);

  final _auth = auth.FirebaseAuth.instance;

  Rx<List<User>> users = Rx<List<User>>([]);

  Stream<auth.User?> userChanges() => _auth.userChanges();

  String? get authId => _auth.currentUser?.uid;

  User? get user => users.value.firstWhereOrNull((user) => user.uuid == authId);

  bool get userCreatedInDatabase => user != null;

  bool get userHasKeywords =>
      userCreatedInDatabase && user!.keywords.isNotEmpty;

  bool get userValid => userCreatedInDatabase && userHasKeywords;

  void registerUser() {
    if (user != null) {
      Get.put(user!);
      isAdmin = user?.email == 'paulo@rock.com';
      if (isAdmin) debugPrint('System Message | Admin successful configured.');
    }
  }
}
