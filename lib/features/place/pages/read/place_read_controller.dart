
import 'package:get/get.dart';
import 'package:pingo/features/place/models/place.dart';

enum PlaceTabItemValue { photos, map, ratings }

class PlaceReadController extends GetxController {
  PlaceReadController(this.place);

  Place place;

  var isMasonry = false.obs;

  void toggleMasonry() => isMasonry(!isMasonry.value);
}
