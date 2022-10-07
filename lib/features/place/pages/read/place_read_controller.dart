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

  final User user = Get.find();
  final CurrentLocation currentLocation = Get.find();

  var currentTab = PlaceTabItemValue.photos.obs;

  void setTabItem(PlaceTabItemValue v) => currentTab(v);

  final mapController = Completer<GoogleMapController>();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Marker get placeMarker => Marker(
        markerId: MarkerId(place.name),
        position: LatLng(
            place.address.location.latitude, place.address.location.longitude),
        infoWindow: InfoWindow(
          title: place.name,
          snippet: place.address.line,
        ),
      );

  Marker get userMarker => Marker(
        markerId: MarkerId(user.name),
        position: LatLng(currentLocation.location.latitude,
            currentLocation.location.longitude),
        infoWindow: InfoWindow(
          title: user.name,
          snippet: 'You are here!',
        ),
      );

  CameraPosition get userPosition => CameraPosition(
        target: LatLng(
          currentLocation.location.latitude,
          currentLocation.location.longitude,
        ),
        zoom: 16,
      );

  CameraPosition get placePosition => CameraPosition(
        target: LatLng(
            place.address.location.latitude, place.address.location.longitude),
        zoom: 16,
      );

  @override
  void onReady() {
    markers[MarkerId(place.name)] = placeMarker;
    markers[MarkerId(user.name)] = userMarker;
    super.onReady();
  }
}
