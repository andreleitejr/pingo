import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/place/repositories/place_repository.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/features/product/models/product_category.dart';
import 'package:pingo/features/product/repositories/product_repository.dart';
import 'package:pingo/models/address.dart';

class ProductEditController extends GetxController {
  ProductEditController(this.place);

  final repository = ProductRepository();
  final Place place;

  var name = ''.obs;
  var description = ''.obs;
  var image = ''.obs;

  var price = 0.0.obs;
  var promotionalPrice = 0.0.obs;
  var placeId = ''.obs;

  var productCategories = <ProductCategory>[].obs;
  var keywords = <int>[].obs;

  void setName(String v) => name(v);

  void setDescription(String v) => description(v);

  void setImage(String v) => image(v);

  void setPrice(String v) => price(double.parse(v));

  void setPromotionalPrice(String v) => promotionalPrice(double.parse(v));

  void toggleCategory(ProductCategory v) {
    if (!productCategories.contains(v)) {
      productCategories.add(v);
    } else {
      productCategories.remove(v);
    }
    print(productCategories);
  }
  void toggleKeyword(int v) {
    if (!keywords.contains(v)) {
      keywords.add(v);
    } else {
      keywords.remove(v);
    }
    print(keywords);
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

  // cityValid &&
  // countryValid &&
  // lineValid &&
  // numberValid &&
  // stateValid &&
  // zipValid

  // Address(
  //   city: city.value,
  //   complement: complement.value,
  //   country: country.value,
  //   line: line.value,
  //   state: state.value,
  //   zip: zip.value,
  //   number: number.value,
  //   location: GeoPoint(latitude.value, longitude.value),
  // );

  Product get product => Product(
        description: description.value,
        name: name.value,
        image: image.value,
        keywords: keywords,
        price: price.value,
        promotionalPrice: promotionalPrice.value,
        placeId: place.uuid,
      );

  Future<void> save() async => await repository.save(product);
}
