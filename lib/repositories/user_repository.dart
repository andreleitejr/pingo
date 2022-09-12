import 'package:pingo/models/user.dart';
import 'package:pingo/repositories/database_repository.dart';

class UserRepository extends DataBaseRepository<User> {
  UserRepository()
      : super(
    name: 'users',
    fromMap: (document) => User.fromMap(document),
  );
}
