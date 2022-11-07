import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/post/models/post.dart';
import 'package:pingo/features/post/repositories/post_repository.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/services/blurhash_controller.dart';
import 'package:pingo/services/camera_controller.dart';

class PostEditController extends GetxController {
  PostEditController(this.place);

  final PostRepository repository = Get.put(PostRepository());

  final cameraController = Get.put(CameraController());

  final blurHashController = Get.put(BlurHashController());

  final User user = Get.find();
  final Place place;

  ImageBlurHash? image;

  var description = ''.obs;
  var displayImage = File('').obs;

  void setDescription(String v) => description(v);

  Future<void> setImage(ImageSource source) async =>
      await cameraController.takePhoto(source, displayImage);

  Post get post => Post(
        placeId: place.uuid,
        description: description.value,
        image: image,
        createdBy: user.uuid,
      );

  Future<void> save() async {
    image = await blurHashController.buildImageBlurHash(
        displayImage.value, repository.name);
    await repository.save(post);
  }
}
