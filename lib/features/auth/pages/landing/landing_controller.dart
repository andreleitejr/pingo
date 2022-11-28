import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pingo/features/auth/pages/landing/landing_page.dart';
import 'package:pingo/main.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/repositories/user_repository.dart';

class LandingController extends GetxController {
  LandingController(this.navigator) {
    onReady();
  }

  final repository = UserRepository();

  final LandingNavigator navigator;

  @override
  void onReady() {
    users.bindStream(repository.read);
    _init();
  }

  final _auth = auth.FirebaseAuth.instance;

  Rx<List<User>> users = Rx<List<User>>([]);

  Future<void> _init() async {
    /// ANIMATION TIME
    await Future.delayed(const Duration(milliseconds: 1500));

    final authUser = _auth.currentUser;

    if (authUser == null) {
      navigator.loggedOut();
    } else if (userValid) {
      registerUser();
      navigator.logged();
    } else {
      registerUser();
      navigator.loggedWithoutInfo();
    }
  }

  String? get authId => _auth.currentUser?.uid;

  User? get user => users.value.firstWhereOrNull((user) => user.uuid == authId);

  bool get userValid => user != null && user!.keywords.isNotEmpty;

  void registerUser() {
    if (user != null) {
      Get.put(user!);
      isAdmin = user?.email == 'paulo@rockdssd.com';
      if (isAdmin) debugPrint('System Message | Admin successful configured.');
    }
  }
}
