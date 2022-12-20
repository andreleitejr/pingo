import 'package:pingo/features/auth/repositories/auth_repository.dart';

abstract class SignUpNavigator {
  void success();

  void error(AuthResult result);
}
