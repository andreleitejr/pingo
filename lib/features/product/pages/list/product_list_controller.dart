import 'package:get/get.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/services/category_controller.dart';

class ProductListController extends GetxController {
  ProductListController(this.products);

  final User user = Get.find();

  List<Product> products;

  final category = Get.put(CategoryController());

  List<Product> get bestProducts {
    final list = products;
    for (final product in list) {
      final match =
          product.keywords.toSet().intersection(user.keywords.toSet()).length;
      product.match = match;
    }
    list.sort((a, b) => a.compareTo(b));
    return list;
  }

  var search = ''.obs;

  void setSearch(String v) => search(v);
}
