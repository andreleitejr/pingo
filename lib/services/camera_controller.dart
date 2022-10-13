import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CameraController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final double maxWidth = 256;
  final double maxHeight = 256;
  final int quality = 75;

  var imageFileList = <XFile>[].obs;

  void _setImageFileListFromFile(XFile? value) {
    if (value != null) imageFileList.add(value);
  }

  dynamic pickImageError;

  String? retrieveDataError;

  Future<void> getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  }

  Future<void> takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.files == null) {
        _setImageFileListFromFile(response.file);
      } else {
        imageFileList.value = response.files ?? [];
      }
    } else {
      retrieveDataError = response.exception!.code;
    }
  }

  Future<void> onImageButtonPressed(ImageSource source,
      {bool isMultiImage = false}) async {
    if (isMultiImage) {
      try {
        final List<XFile> pickedFileList = await _picker.pickMultiImage(
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: quality,
        );

        imageFileList.value = pickedFileList;
      } catch (e) {
        debugPrint('An error ocurred getting multiple images: $e');
        pickImageError = e;
      }
    } else {
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: quality,
        );

        _setImageFileListFromFile(pickedFile);
      } catch (e) {
        debugPrint('An error ocurred getting image: $e');
        pickImageError = e;
      }
    }
  }
}
