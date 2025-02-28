import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/features/product/models/product_category.dart';
import 'package:pingo/features/product/repositories/product_repository.dart';
import 'package:pingo/models/image_blurhash.dart';
import 'package:pingo/services/blurhash_controller.dart';
import 'package:pingo/services/camera_controller.dart';

class ProductEditController extends GetxController {
  ProductEditController(this.place);

  final repository = ProductRepository();

  final Place place;

  final cameraController = Get.put(CameraController());

  final blurHashController = Get.put(BlurHashController());

  var name = ''.obs;

  var description = ''.obs;

  var displayImage = File('').obs;

  var price = 0.0.obs;

  var promotionalPrice = 0.0.obs;

  var placeId = ''.obs;

  ImageBlurHash? image;

  var productCategories = <ProductCategory>[].obs;

  var keywords = <int>[].obs;

  void setName(String v) => name(v);

  void setDescription(String v) => description(v);

  Future<void> setImage(ImageSource source) async {
    await cameraController.onImageButtonPressed(source);

    if (cameraController.imageFileList.isNotEmpty) {
      final imagePath = cameraController.imageFileList.first.path;

      File file = File(imagePath);
      displayImage(file);

      cameraController.imageFileList.clear();
    }
  }

  void setPrice(String v) => price(double.parse(v));

  void setPromotionalPrice(String v) => promotionalPrice(double.parse(v));

  void toggleCategory(ProductCategory v) {
    if (!productCategories.contains(v)) {
      productCategories.add(v);
    } else {
      productCategories.remove(v);
    }
  }

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

  bool get isValid => nameValid && descriptionValid;

  Product get product => Product(
        description: description.value,
        name: name.value,
        image: image,
        keywords: keywords,
        price: price.value,
        promotionalPrice: promotionalPrice.value,
        placeId: place.uuid,
      );

  Future<void> save() async {
    image = await blurHashController.buildImageBlurHash(
        displayImage.value, repository.name);
    await repository.save(product);
  }
}
