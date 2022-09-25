import 'package:get/get.dart';
import 'package:pingo/models/base.dart';
import 'package:pingo/models/buyable.dart';

class FilterController extends GetxController {
  var minValue = 0.0.obs;
  var maxValue = 10000.0.obs;

  var distance = 2000.0.obs;

  var minPrice = 0.0.obs;
  var maxPrice = 20000.0.obs;

  var rating = 1.obs;

  int get divisions {
    final lessThanOneKm = distance < 1000;
    final lessThanFiveKm = distance < 5000;
    final lessThanTenKm = distance >= 5000 && distance < 10000;

    late double dividerValue;
    if (lessThanOneKm) {
      dividerValue = 10;
    } else if (lessThanFiveKm) {
      dividerValue = 100;
    } else if (lessThanTenKm) {
      dividerValue = 1000;
    } else {
      dividerValue = 10000;
    }

    return (maxValue / dividerValue).floor();
  }

  void setDistance(double v) => distance(v);

  void setRating(int v) => rating(v);

  void setMinPrice(String v) => minPrice(double.parse(v));

  void setMaxPrice(String v) => maxPrice(double.parse(v));

  List<Base> filterPlaceByDistance(List<Base> list) =>
      list.where((place) => place.distance <= distance.value).toList();

  List<Base> filterPlaceByRating(List<Base> list) =>
      list.where((place) => place.rating >= rating.value).toList();

  List<Buyable> filterProductByPrice(List<Buyable> list) => list
      .where((buyable) =>
          buyable.price >= minPrice.value && buyable.price <= maxPrice.value)
      .toList();
}
