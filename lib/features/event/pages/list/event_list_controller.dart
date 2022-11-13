import 'package:get/get.dart';
import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/models/user.dart';

class EventListController extends GetxController {
  EventListController(this.events);

  final User user = Get.find();

  List<Event> events;

  List<Event> get bestMatch {
    final list = events;
    for (final event in list) {
      final match =
          event.keywords.toSet().intersection(user.keywords.toSet()).length;
      event.match = match;
    }
    list.sort((a, b) => a.compareTo(b));
    return list;
  }

  var search = ''.obs;

  void setSearch(String v) => search(v);
}
