import 'package:get/get.dart';
import 'package:pingo/models/base.dart';
import 'package:pingo/models/buyable.dart';
import 'package:pingo/models/matchbase.dart';

class FilterController extends GetxController {
  var min = 0.0.obs;
  var max = 10000.0.obs;

  var distance = 2000.0.obs;

  var minPrice = 0.0.obs;
  var maxPrice = 20000.0.obs;

  var rating = 1.obs;

  var match = 0.obs;

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

    return (max / dividerValue).floor();
  }

  void setDistance(double v) => distance(v);

  void cleanDistance() => distance(2000);

  void setRating(int v) => rating(v);

  void cleanRating() => rating(1);

  void setMinPrice(double v) => minPrice(v);

  void setMaxPrice(double v) => maxPrice(v);

  void setMatch(MatchItem v) => match(v.value);

  void cleanMatch() => match(matchItems.last.value);

  void cleanPrice() {
    minPrice(0);
    maxPrice(20000);
  }

  void cleanAll() {
    cleanDistance();
    cleanRating();
    cleanPrice();
  }

  List<Base> filterPlaceByDistance(List<Base> list) =>
      list.where((base) => base.distance <= distance.value).toList();

  List<Base> filterPlaceByRating(List<Base> list) =>
      list.where((base) => base.rating >= rating.value).toList();

  List<MatchBase> filterByMatch(List<MatchBase> list) => list
      .where((matchBase) =>
          matchBase.match != null && matchBase.match! >= match.value)
      .toList();

  List<Buyable> filterProductByPrice(List<Buyable> list) => list
      .where((buyable) =>
          buyable.price >= minPrice.value && buyable.price <= maxPrice.value)
      .toList();
}
