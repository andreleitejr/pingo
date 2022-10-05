import 'package:get/get.dart';
import 'package:pingo/features/auth/repositories/auth_repository.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/repositories/user_repository.dart';

class SignInController extends GetxController {
  final repository = AuthRepository();

  final email = ''.obs;

  final password = ''.obs;

  void setEmail(String v) => email(v);

  void setPassword(String v) => password(v);

  bool get emailValid => GetUtils.isEmail(email.value);

  bool get passwordValid => password.value.isNotEmpty;

  bool get isAuthFormValid => emailValid && passwordValid;

  Future<AuthResult> signIn() async {
    final result = await repository.signInWithEmailAndPassword(
        email.value, password.value);
    return result;
  }
}
