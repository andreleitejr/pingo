import 'package:get/get.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/models/category.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/services/category_controller.dart';

class EventListController extends GetxController {
  EventListController(this.events);

  final User user = Get.find();

  List<Event> events;

  final category = Get.put(CategoryController());

  var categories = <Category>[].obs;

  List<Event> get bestMatch {
    var list = events;
    for (final event in list) {
      final match =
          event.keywords.toSet().intersection(user.keywords.toSet()).length;
      event.match = match;
    }

    if (search.isNotEmpty) {
      list = list.where((event) {
        if (event.name.clean.contains(search.value.clean)) {
          return true;
        } else if (event.description != null &&
            event.description!.clean.contains(search.value.clean)) {
          return true;
        }
        return false;
      }).toList();
    }

    list = category.filterByCategory(list) as List<Event>;

    list.sort((a, b) => a.compareTo(b));
    return list;
  }

  var search = ''.obs;

  void setSearch(String v) => search(v);

  @override
  void onInit() {
    final c = category.get(CategoryType.events);
    categories(c);
    super.onInit();
  }
}
