import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/emails.dart';
import 'package:pingo/features/auth/pages/landing/landing_page.dart';
import 'package:pingo/features/auth/repositories/auth_repository.dart';
import 'package:pingo/i18n/strings.g.dart';
import 'package:pingo/main.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/repositories/user_repository.dart';

class LandingController extends GetxController {
  LandingController(this.navigator) {
    onReady();
  }

  final repository = UserRepository();

  final LandingNavigator navigator;

  auth.User? authUser;

  @override
  void onReady() {
    users.bindStream(repository.read);
    _verifyAuthStatus();
    _configureAuthLanguage();
  }

  final authRepository = Get.put(AuthRepository());

  Rx<List<User>> users = Rx<List<User>>([]);

  Future<void> _configureAuthLanguage() async {
    final locale = LocaleSettings.useDeviceLocale();
    final code = locale.flutterLocale.languageCode;
    await authRepository.setLanguageCode(code);
  }

  Future<void> _verifyAuthStatus() async {
    /// ANIMATION TIME
    await Future.delayed(const Duration(milliseconds: 1500));

    authUser = await authRepository.currentUser();

    if (authUser == null) {
      navigator.loggedOut();
    } else if (userNotFound) {
      navigator.loggedWithoutUser();
    } else if (userWithoutKeywords) {
      registerUser();
      navigator.loggedWithoutKeyword();
    } else if (userValid) {
      registerUser();
      navigator.logged();
    }
  }

  String? get authId => authUser?.uid;

  User? get user => users.value.firstWhereOrNull((user) => user.uuid == authId);

  bool get userNotFound => user == null;

  bool get userWithoutKeywords => !userNotFound && user!.keywords.isEmpty;

  bool get userValid => !userNotFound && user!.keywords.isNotEmpty;

  void registerUser() {
    Get.put(user!);
    _verifyAdmin();
  }

  void _verifyAdmin() {
    isAdmin = user?.email == Emails.admin;
    if (isAdmin) debugPrint('System Message | Admin successful configured.');
  }
}
