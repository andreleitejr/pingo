import 'package:get/get.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/place/repositories/place_repository.dart';

class HomeController extends GetxController {
  HomeController(this.keywordsIds);

  final List<int> keywordsIds;


  final repository = PlaceRepository();

  Rx<List<Place>> placeList = Rx<List<Place>>([]);

  // ORDER BY DISTANCE
  List<Place> get places => placeList.value;

  List<Place> get bestMatch {
    for (final place in places) {
      print(place.name);
      print(place.keywords.toSet().intersection(keywordsIds.toSet()).length);
      final match =
          place.keywords.toSet().intersection(keywordsIds.toSet()).length;
      place.match = match;
    }
    places.sort((a, b) => a.match!.compareTo(b.match!));

    return places;
  }

  @override
  void onReady() {
    placeList.bindStream(repository.read);
  }
}
