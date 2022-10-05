import 'package:get/get.dart';
import 'package:pingo/features/auth/repositories/auth_repository.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/repositories/user_repository.dart';

class SignInController extends GetxController {
  final repository = AuthRepository();

  final userRepository = UserRepository();
  Rx<List<User>> users = Rx<List<User>>([]);

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
    if (result == AuthResult.success) {
      final authUser = await repository.currentUser();
      return getUser(authUser?.uid);
    }
    return result;
  }

  AuthResult getUser(String? currentUserId) {
    users.bindStream(userRepository.read);

    if (users.value.isEmpty) return AuthResult.failed;

    final user =
        users.value.firstWhereOrNull((user) => user.uuid == currentUserId);

    if (user != null) {
      Get.put(user);
      return AuthResult.success;
    } else {
      return AuthResult.userNotFoundInDatabase;
    }
  }
}
