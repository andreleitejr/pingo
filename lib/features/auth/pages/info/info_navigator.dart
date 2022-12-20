import 'package:pingo/features/auth/repositories/auth_repository.dart';

abstract class SignUpInfoNavigator {
  void success();

  void error(AuthResult result);
}
