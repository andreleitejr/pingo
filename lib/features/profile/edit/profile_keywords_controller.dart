import 'package:get/get.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/repositories/user_repository.dart';
import 'package:pingo/widgets/design_page_view.dart';

class ProfileKeywordsController extends GetxController {
  final repository = UserRepository();
  final PageViewController pageView = Get.put(PageViewController());

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

  // PESQUISAR
  List<String> get keywordsStringList {
    final list = <String>[];

    for (final keyword in keywords) {
      list.add(keyword.id.toString());
    }
    return list;
  }

  List<int> get keywordIds {
    final ids = <int>[];
    if (keywordsStringList.isNotEmpty) {
      for (final keywordString in keywordsStringList) {
        ids.add(int.parse(keywordString));
      }
    }
    return ids;
  }

  final User user = Get.find();

  Future<void> updateUser() async {
    user.keywords.addAll(keywordIds);
    repository.update(user.uuid, user);
  }
}