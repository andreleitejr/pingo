import 'package:get/get.dart';
import 'package:pingo/features/auth/pages/signin/signin_navigator.dart';
import 'package:pingo/features/auth/repositories/auth_repository.dart';

class SignInController extends GetxController {
  SignInController(this.navigator);

  final repository = AuthRepository();

  final SignInNavigator navigator;

  final email = ''.obs;

  final password = ''.obs;

  final showRecoveryMessage = false.obs;

  String get recoveryMessage => showRecoveryMessage.value
      ? 'Verify your e-mail box (or spam) and try again with you new passowrd.'
      : ' Esqueceu sua senha?';

  void setEmail(String v) => email(v);

  void setPassword(String v) => password(v);

  bool get emailValid => GetUtils.isEmail(email.value);

  bool get passwordValid => password.value.isNotEmpty;

  bool get isAuthFormValid => emailValid && passwordValid;

  Future<void> signIn() async {
    if (isAuthFormValid) {
      final result = await repository.signInWithEmailAndPassword(
          email.value, password.value);
      if (result == AuthResult.success) {
        navigator.success();
      } else if (result == AuthResult.userNotFoundInDatabase) {
        navigator.userNotFoundInDatabase();
      } else {
        navigator.error(result);
      }
    } else {
      navigator.error(AuthResult.required);
    }
  }
}
