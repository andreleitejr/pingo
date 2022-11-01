import 'package:get/get.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:share_plus/share_plus.dart';

enum PlaceTabItemValue { photos, map, ratings }

class PlaceReadController extends GetxController {
  PlaceReadController(this.place);

  Place place;

  var isMasonry = false.obs;

  void toggleMasonry() => isMasonry(!isMasonry.value);

  Future<void> share() async {
    await Share.share('Check out this great place I found.',
        subject: place.name);
  }
}
