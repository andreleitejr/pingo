import 'package:get/get.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/auth/pages/signup/signup_page.dart';
import 'package:pingo/features/auth/repositories/auth_repository.dart';

class SignUpController extends GetxController {
  SignUpController(this.navigator);

  final repository = AuthRepository();

  final SignUpNavigator navigator;
  final name = ''.obs;
  final email = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;
  final acceptedTermsAndConditions = false.obs;

  void setName(String v) => name(v);

  void setEmail(String v) => email(v);

  void setPassword(String v) => password(v);

  void setConfirmPassword(String v) => confirmPassword(v);

  void toggleTermsAndConditions(bool? v) => acceptedTermsAndConditions(v!);

  bool get nameValid => name.value.length >= 6;

  bool get emailValid => GetUtils.isEmail(email.value);

  bool get passwordValid => password.value.passwordValid;

  bool get confirmPasswordValid =>
      confirmPassword.value.isNotEmpty &&
      confirmPassword.value == password.value;

  bool get isAuthFormValid =>
      nameValid &&
      emailValid &&
      passwordValid &&
      confirmPasswordValid &&
      acceptedTermsAndConditions.value;

  Future<void> signUpWithEmailAndPassword() async {
    if (isAuthFormValid) {
      final result = await repository.signUpWithEmailAndPassword(
          name.value, email.value, password.value);

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
