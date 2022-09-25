import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get/get.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/repositories/user_repository.dart';

class LandingController extends GetxController {
  LandingController() {
    onReady();
  }

  final repository = UserRepository();

  @override
  void onReady() => users.bindStream(repository.read);

  final _auth = auth.FirebaseAuth.instance;

  Rx<List<User>> users = Rx<List<User>>([]);

  Stream<auth.User?> userChanges() => _auth.userChanges();

  String? get authId => _auth.currentUser?.uid;

  User? get user {
    return users.value.firstWhereOrNull((user) => user.uuid == authId);
  }

  bool get userRegisteredButNotCreatedInDatabase =>
      _auth.currentUser != null && user == null;

  bool get userCreatedInDatabase {
    return users.value.any((u) => u.uuid == _auth.currentUser?.uid);
  }

  bool get keywordsSavedInDatabase {
    return user != null && userCreatedInDatabase && user!.keywords.isNotEmpty;
  }

  bool get userValid =>
      user != null && userCreatedInDatabase && keywordsSavedInDatabase;

  void registerUser() {
    if (user != null) {
      Get.put(user!);
    }
  }
}
