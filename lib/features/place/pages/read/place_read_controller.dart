import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pingo/core/current_location.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/models/user.dart';

enum PlaceTabItemValue { photos, map, ratings }

class PlaceReadController extends GetxController {
  PlaceReadController(this.place);

  Place? place;

  final CurrentLocation currentLocation = Get.find();

  var currentTab = PlaceTabItemValue.photos.obs;

  void setTabItem(PlaceTabItemValue v) => currentTab(v);

  final mapController = Completer<GoogleMapController>();

  CameraPosition get userPosition => CameraPosition(
        target: LatLng(
          currentLocation.location.latitude,
          currentLocation.location.longitude,
        ),
        zoom: 15,
      );

  CameraPosition get placePosition => CameraPosition(
        target: LatLng(place!.address.location.latitude,
            place!.address.location.longitude),
        zoom: 15,
      );
}
