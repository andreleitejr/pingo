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
  void onReady() {
    // SharedPreferences sharedPreferences = Get.find();

    // keywordStringList = sharedPreferences.getStringList('keywords');

    users.bindStream(repository.read);
    // placeList.bindStream(placeRepo.read);

    print('INIT HSDUDASHUDSHSDAUASD REGISTER USER $user');
  }

  // List<String>? keywordStringList;
  //
  // List<int> get keywordIds {
  //   final ids = <int>[];
  //   if (keywordStringList != null && keywordStringList!.isNotEmpty) {
  //     for (final keywordString in keywordStringList!) {
  //       ids.add(int.parse(keywordString));
  //     }
  //   }
  //   return ids;
  // }

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
      print('HSDUDASHUDSHSDAUASD REGISTER USER ${user?.uuid}');
      Get.put(user!);
    }
  }

// final placeRepo = PlaceRepository();
//
// Rx<List<Place>> placeList = Rx<List<Place>>([]);
//
// // ORDER BY DISTANCE
// List<Place> get places => placeList.value;
}
