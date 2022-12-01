import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pingo/features/auth/pages/recover/recover_page.dart';
import 'package:pingo/features/auth/repositories/auth_repository.dart';

class RecoverPasswordController extends GetxController {
  RecoverPasswordController(this.navigator, {String? email}) {
    this.email(email);
  }

  final repository = AuthRepository();

  final RecoverNavigator navigator;

  final emailController = TextEditingController();

  final email = ''.obs;

  void setEmail(String v) => email(v);

  bool get emailValid => GetUtils.isEmail(email.value);

  Future<void> recoverPassword() async {
    if (emailValid) {
      final result = await repository.recoverPassword(email.value);

      if (result == AuthResult.success) {
        navigator.success();
      } else {
        navigator.error(result);
      }
    } else {
      navigator.error(AuthResult.required);
    }
  }
}
