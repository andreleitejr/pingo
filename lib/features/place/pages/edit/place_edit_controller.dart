import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pingo/services/current_location.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/place/repositories/place_repository.dart';
import 'package:pingo/models/address.dart';
import 'package:pingo/services/camera_controller.dart';
import 'package:pingo/services/blurhash_controller.dart';

class PlaceEditController extends GetxController {
  final repository = PlaceRepository();

  final cameraController = Get.put(CameraController());

  final blurHashController = Get.put(BlurHashController());

  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  final subLocalityController = TextEditingController();
  final zipController = TextEditingController();

  var displayImage = File('').obs;
  var displayPhotos = <File>[].obs;

  var name = ''.obs;
  var description = ''.obs;
  var email = ''.obs;
  ImageBlurHash? image;
  final photos = <ImageBlurHash>[];

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

  Future<void> setImage(ImageSource source) async =>
      await cameraController.takePhoto(source, displayImage);

  Future<void> selectPhotos(ImageSource source) async =>
      await cameraController.takeMultiplePhotos(source, displayPhotos);

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
        image: image,
        photos: photos,
        keywords: keywords,
      );

  Future<void> save() async {
    image = await blurHashController.buildImageBlurHash(
        displayImage.value, repository.name);
    for (final displayPhoto in displayPhotos) {
      final photo = await blurHashController.buildImageBlurHash(
          displayPhoto, repository.name);
      if (photo != null) photos.add(photo);
    }
    debugPrint('Successful converted photos: ${photos.length}');
    await repository.save(place);
  }
}
