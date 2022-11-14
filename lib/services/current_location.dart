import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pingo/core/extensions.dart';

class CurrentLocation {
  late GeoPoint currentCoordinates;
  Placemark? placemark;

  Future<void> init() async {
    final permission = await Geolocator.requestPermission();

    if (permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever) {
      await _getCurrentLocation();
      // currentCoordinates =
      //     const GeoPoint(-23.548842918924585, -46.64632573035709);
      await _getStreetName();
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      final currentLocation = await Geolocator.getCurrentPosition();

      currentCoordinates = currentLocation.toGeoPoint;

      Geolocator.getPositionStream().listen((Position? currentLocation) {
        if (currentLocation != null) {
          currentCoordinates = currentLocation.toGeoPoint;
          debugPrint(
              'CURRENT LOCATION CHANGED | ${currentCoordinates.latitude}, ${currentCoordinates.longitude}');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getStreetName() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        currentCoordinates.latitude, currentCoordinates.longitude);

    placemark = placemarks.first;
  }

  static Future<GeoPoint> getCoordinates(String line) async {
    List<Location> locations = await locationFromAddress(line);
    return GeoPoint(locations.first.latitude, locations.first.longitude);
  }

  static Future<Placemark> getAddress(GeoPoint location) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.latitude, location.longitude);
    return placemarks.first;
  }

  String get currentAddress =>
      '${placemark?.street}, ${placemark?.subLocality}';
}
