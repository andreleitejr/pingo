import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pingo/core/extensions.dart';

class CurrentLocation {
  late GeoPoint currentCoordinates;
  String currentAddress = '';


  Future<void> init() async {
    final permission = await Geolocator.requestPermission();

    if (permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever) {
      // await _getCurrentLocation();
      currentCoordinates = const GeoPoint(-23.55041838770605, -46.64824828296933);
      await _getStreetName();
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      final currentLocation = await Geolocator.getCurrentPosition();
      currentCoordinates = currentLocation.toGeoPoint;
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getStreetName() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(currentCoordinates.latitude, currentCoordinates.longitude);

    if (placemarks.first.street != null) {
      currentAddress += placemarks.first.street!;
    }
    if (placemarks.first.administrativeArea != null) {
      currentAddress += ', ${placemarks.first.administrativeArea!}';
    }
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
}
