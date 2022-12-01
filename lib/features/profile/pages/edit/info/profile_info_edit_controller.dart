import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/repositories/user_repository.dart';
import 'package:pingo/services/blurhash_controller.dart';
import 'package:pingo/services/camera_controller.dart';

class ProfileInfoEditController extends GetxController {
  final User user = Get.find();
  final repository = Get.put(UserRepository());
  final cameraController = Get.put(CameraController());
  final blurHashController = Get.put(BlurHashController());

  var displayImage = File('').obs;

  void setName(String v) => user.name = v;

  void setDescription(String v) => user.description = v;

  void setNickname(String v) => user.nickname = v;

  Future<void> setImage(ImageSource source) async {
    await cameraController.takePhoto(source, displayImage);

    user.image = await blurHashController.buildImageBlurHash(
        displayImage.value, repository.name);
  }

  Future<void> save() async => repository.update(user.uuid, user);
}
