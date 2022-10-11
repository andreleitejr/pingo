import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pingo/core/current_location.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/place/repositories/place_repository.dart';
import 'package:pingo/models/address.dart';
import 'package:pingo/services/camera.dart';

class PlaceEditController extends GetxController {
  final repository = PlaceRepository();

  final camera = Get.put(CameraController());

  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  final subLocalityController = TextEditingController();
  final zipController = TextEditingController();

  var name = ''.obs;
  var description = ''.obs;
  var email = ''.obs;
  File? image;

  var closeHour = 23.obs;
  var closeMinute = 0.obs;
  var openHour = 23.obs;
  var openMinute = 0.obs;

  var city = ''.obs;
  var complement = ''.obs;
  var country = ''.obs;
  var line = ''.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var subLocality = ''.obs;
  var number = ''.obs;
  var state = ''.obs;
  var zip = ''.obs;

  var keywords = <int>[].obs;

  void setName(String v) => name(v);

  void setDescription(String v) => description(v);

  void setEmail(String v) => email(v);

  Future<void> setImage(ImageSource source, {bool isMultiImage = false}) async {
    await camera.onImageButtonPressed(source, isMultiImage: isMultiImage);

    if (camera.imageFileList.isNotEmpty) {
      final imagePath = camera.imageFileList.first.path;

      File file = File(imagePath);
      image = file;

      // final uploadTask = await repository.upload(file, place.name);
      print('##################### FILE ${image?.path}');

      // final link = await repository.downloadLink(uploadTask!.snapshot.ref);
    }
  }

  void setCloseHour(String v) => closeHour(int.tryParse(v));

  void setCloseMinute(String v) => closeMinute(int.tryParse(v));

  void setOpenHour(String v) => openHour(int.tryParse(v));

  void setOpenMinute(String v) => openMinute(int.tryParse(v));

  void setCity(String v) => city(v);

  void setComplement(String v) => complement(v);

  void setLine(String v) => line(v);

  void setLatitude(String v) => latitude(double.tryParse(v));

  void setLongitude(String v) => longitude(double.tryParse(v));

  void setSubLocality(String v) => subLocality(v);

  Future<void> setNumber(String v) async {
    number(v);

    final address = '${line.value}, ${number.value}';
    final location = await CurrentLocation.getCoordinates(address);
    latitude(location.latitude);
    latitudeController.text = latitude.toString();
    longitude(location.longitude);
    longitudeController.text = longitude.toString();

    final placemarks = await CurrentLocation.getAddress(location);

    subLocality(placemarks.subLocality);
    subLocalityController.text = subLocality.value;
    zip(placemarks.postalCode);
    zipController.text = zip.value;
  }

  void setState(String v) => state(v);

  void setZip(String v) => zip(v);

  void toggleKeyword(int v) {
    if (!keywords.contains(v)) {
      keywords.add(v);
    } else {
      keywords.remove(v);
    }
  }

  String getStringFormattedHour(int hour, int minute) {
    if (hour >= 24) {
      hour = 23;
    }
    String h = hour <= 0 ? '0$hour' : hour.toString();

    if (minute >= 60) {
      minute = 59;
    }
    String m = minute <= 0 ? '0$minute' : minute.toString();

    return '$h:$m';
  }

  bool get nameValid => name.isNotEmpty;

  bool get descriptionValid => description.isNotEmpty;

  bool get emailValid =>
      email.isNotEmpty ? GetUtils.isEmail(email.value) : true;

  bool get cityValid => city.isNotEmpty;

  // bool get countryValid => country.isNotEmpty;

  bool get lineValid => line.isNotEmpty;

  bool get numberValid => number.isNotEmpty;

  // bool get stateValid => state.isNotEmpty;

  bool get subLocalityValid => subLocality.isNotEmpty;

  bool get zipValid => zip.isNotEmpty;

  bool get isValid =>
      nameValid &&
      descriptionValid &&
      // cityValid &&
      // countryValid &&
      lineValid &&
      numberValid &&
      // stateValid &&
      subLocalityValid &&
      zipValid;

  Address get address => Address(
        city: 'São Paulo',
        complement: complement.value,
        country: 'Brazil',
        line: line.value,
        location: GeoPoint(latitude.value, longitude.value),
        subLocality: subLocality.value,
        number: number.value,
        state: 'São Paulo',
        zip: zip.value,
      );

  Place get place => Place(
        address: address,
        description: description.value,
        name: name.value,
        email: email.value,
        open: '08:30',
        close: '22:30',
        image: 'https://i.ibb.co/WPXwnYF/pingo.jpg',
        keywords: keywords,
      );

  Future<void> save() async => await repository.save(place);
}
