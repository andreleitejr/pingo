import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pingo/core/current_location.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/models/user.dart';

enum PlaceTabItemValue { photos, map, ratings }

class PlaceReadController extends GetxController {
  PlaceReadController(this.place);

  Place place;

  var isMasonry = false.obs;

  void toggleMasonry() => isMasonry(!isMasonry.value);
}
