import 'package:pingo/features/auth/repositories/auth_repository.dart';

abstract class SignInNavigator {
  void success();

  void userNotFoundInDatabase();

  void error(AuthResult result);
}
