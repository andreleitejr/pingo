import 'package:get/get.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/home/category/category.dart';
import 'package:pingo/features/place/models/place.dart';

class CategoryController extends GetxController {
  var category = categories.first.obs;

  void setCategory(Category v) => category(v);

  List<Place> _build(List<Place> list, List<int> keywords) {
    return list
        .where((place) =>
            place.keywords.any((keyword) => keywords.contains(keyword)))
        .toList();
  }

  List<Place> filterByCategory(List<Place> list) {
    switch (category.value.id) {
      case Category.all:
        return list;
      case Category.restaurants:
        return _build(list, [Keyword.restaurant]);
      case Category.pubs:
        return _build(list, [Keyword.pub]);
      case Category.shopping:
        return _build(list, [Keyword.shopping]);
      case Category.fastFoods:
        return _build(list, [Keyword.fastFood]);
      case Category.theaters:
        return _build(list, [Keyword.theater]);
      case Category.museums:
        return _build(list, [Keyword.museum]);
      case Category.historical:
        return _build(list, [Keyword.historical]);
      case Category.utils:
        return _build(list, [Keyword.util]);
    }
    return [];
  }
}
