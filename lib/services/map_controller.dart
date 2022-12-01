import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pingo/models/pin.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/services/current_location.dart';

class MapController extends GetxController {
  MapController({required this.pin});

  final Pin pin;

  final mapController = Completer<GoogleMapController>();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  final User user = Get.find();

  final CurrentLocation currentLocation = Get.find();

  Marker get placeMarker => Marker(
        markerId: MarkerId(pin.markerId),
        position: LatLng(pin.latitude, pin.longitude),
        infoWindow: InfoWindow(
          title: pin.markerId,
          snippet: pin.markerDescription,
        ),
      );

  Marker get userMarker => Marker(
        markerId: MarkerId(user.name),
        position: LatLng(
          currentLocation.currentCoordinates.latitude,
          currentLocation.currentCoordinates.longitude,
        ),
        infoWindow: InfoWindow(
          title: user.name,
          snippet: 'You are here!',
        ),
      );

  CameraPosition get userPosition => CameraPosition(
        target: LatLng(
          currentLocation.currentCoordinates.latitude,
          currentLocation.currentCoordinates.longitude,
        ),
        zoom: 15,
      );

  CameraPosition get placePosition => CameraPosition(
        target: LatLng(pin.latitude, pin.longitude),
        zoom: 15,
      );

  @override
  void onReady() {
    markers[MarkerId(user.name)] = userMarker;
    markers[MarkerId(pin.markerId)] = placeMarker;
    super.onReady();
  }
}
