import 'package:get/get.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/models/category.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/services/category_controller.dart';

class ProductListController extends GetxController {
  ProductListController(this.products);

  final User user = Get.find();

  List<Product> products;

  final category = Get.put(CategoryController());

  var categories = <Category>[].obs;

  List<Product> get bestProducts {
    var list = products;
    for (final product in list) {
      final match =
          product.keywords.toSet().intersection(user.keywords.toSet()).length;
      product.match = match;
    }

    if (search.isNotEmpty) {
      list = list.where((product) {
        if (product.name.clean.contains(search.value.clean)) {
          return true;
        } else if (product.description != null &&
            product.description!.clean.contains(search.value.clean)) {
          return true;
        }
        return false;
      }).toList();
    }

    list = category.filterByCategory(list) as List<Product>;

    list.sort((a, b) => a.compareTo(b));

    return list;
  }

  var search = ''.obs;

  void setSearch(String v) => search(v);

  @override
  void onInit() {
    final c = category.get(CategoryType.products);
    categories(c);
    super.onInit();
  }
}
