import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/place/repositories/place_repository.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingController extends GetxController {
  LandingController() {
    onReady();
  }

  final repository = UserRepository();

  @override
  void onReady() {
    SharedPreferences sharedPreferences = Get.find();

    keywordStringList = sharedPreferences.getStringList('keywords');

    users.bindStream(repository.read);
    placeList.bindStream(placeRepo.read);
  }

  List<String>? keywordStringList;

  List<int> get keywordIds {
    final ids = <int>[];
    if (keywordStringList != null && keywordStringList!.isNotEmpty) {
      for (final keywordString in keywordStringList!) {
        ids.add(int.parse(keywordString));
      }
    }
    return ids;
  }

  final _auth = auth.FirebaseAuth.instance;

  Rx<List<User>> users = Rx<List<User>>([]);
  Rx<List<String>> keywords = Rx<List<String>>([]);

  Stream<auth.User?> userChanges() => _auth.userChanges();

  bool get userCreatedInDatabase {
    return users.value.any((u) => u.uuid == _auth.currentUser?.uid);
  }

  bool get keywordsCreatedInCache => keywordIds.isNotEmpty;

  final placeRepo = PlaceRepository();

  Rx<List<Place>> placeList = Rx<List<Place>>([]);

  // ORDER BY DISTANCE
  List<Place> get places => placeList.value;
}
