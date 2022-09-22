import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pingo/core/extensions.dart';

class CurrentLocation {
  late GeoPoint location;
  String streetName = '';

  Future<void> init() async {
    final permission = await Geolocator.requestPermission();

    if (permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever) {
      // await _getCurrentLocation();
      location = const GeoPoint(-23.548471, -46.6466175);
      print('Location: ${location.latitude}, ${location.longitude}');
      await _getStreetName();
      print('Location: ${location.latitude}, ${location.longitude}');
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      final currentLocation = await Geolocator.getCurrentPosition();
      location = currentLocation.toGeoPoint;
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getStreetName() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.latitude, location.longitude);
print(placemarks.first.street);
    if (placemarks.first.street != null) streetName = placemarks.first.street!;
    print('Street Nameddd: $streetName');
  }
}
