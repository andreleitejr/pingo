import 'package:get/get.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/models/base.dart';

class SearchController extends GetxController {
  var text = ''.obs;

  void setSearch(String v) {
    text(v);
    searchActive(true);
  }

  List<Base> filterBySearch(List<Base> list) => list.where(
        (base) {
          final cleanText = text.value.clean;
          if (base.name.clean.contains(cleanText)) {
            return true;
          } else if (base.description != null &&
              base.description!.clean.contains(cleanText)) {
            return true;
          } else if (base.keywordData
              .any((keyword) => keyword.title.clean.contains(cleanText))) {
            return true;
          }
          return false;
        },
      ).toList();

  var searchActive = false.obs;

  void closeSearch() {
    text('');
    searchActive(false);
  }
}
