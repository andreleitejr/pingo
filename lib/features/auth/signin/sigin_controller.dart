import 'package:get/get.dart';
import 'package:pingo/features/auth/repositories/auth_repository.dart';
import 'package:pingo/repositories/user_repository.dart';

class SignInController extends GetxController {
  final repository = AuthRepository();

  final userRepository = UserRepository();

  final email = ''.obs;

  final password = ''.obs;

  void setEmail(String v) => email(v);

  void setPassword(String v) => password(v);

  bool get emailValid => GetUtils.isEmail(email.value);

  bool get passwordValid => password.value.isNotEmpty;

  Future<void> signIng() async {
    try {
      await repository.signInWithEmailAndPassword(email.value, password.value);
    } catch (e) {
      print(e);
    }
  }
}
