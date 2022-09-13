import 'package:get/get.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/widgets/design_page_view.dart';

class ProfileKeywordsController extends GetxController {
  final PageViewController pageView = Get.find();

  var keywords = <Keyword>[].obs;

  void toggleKeyword(Keyword v) {
    if (!keywords.contains(v)) {
      keywords.add(v);
    } else {
      keywords.remove(v);
    }
  }

  final int minPlacesSelected = 1;
  final int minFoodsSelected = 1;
  final int minMusicsSelected = 1;
  final int minMiscellaneousSelected = 5;

  bool quantityValid(List<Keyword> items, int expectedQuantity) {
    return items.toSet().intersection(keywords.toSet()).length >=
        expectedQuantity;
  }
}
