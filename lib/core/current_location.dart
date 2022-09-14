import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pingo/core/extensions.dart';

class CurrentLocation {
  static Future<void> init() async {

    final permission = await Geolocator.requestPermission();

    if (permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever) {
     await  _getCurrentLocation();
    }
  }

  static Future<void> _getCurrentLocation() async {
    try {
      final currentLocation = await Geolocator.getCurrentPosition();
      Get.put(currentLocation.toGeoPoint);
    } catch (e) {
      print(e);
    }
  }
}
