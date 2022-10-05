// import 'package:get/get.dart';
// import 'package:pingo/core/keyword.dart';
// import 'package:pingo/widgets/design_page_view.dart';
//
// class KeywordSelectionController extends GetxController {
//
//
//   KeywordSelectionController(this.list);
//
//   List<KeywordData> list;
//
//   final pageView = PageViewController();
//
//   var keywords = <KeywordData>[].obs;
//
//   void toggleKeyword(KeywordData v) {
//     if (!keywords.contains(v)) {
//       keywords.add(v);
//     } else {
//       keywords.remove(v);
//     }
//   }
//
//   bool quantityValid(List<KeywordData> items, int expectedQuantity) {
//     return items.toSet().intersection(keywords.toSet()).length >=
//         expectedQuantity;
//   }
//
//   // PESQUISAR
//   List<String> get keywordsStringList {
//     final list = <String>[];
//
//     for (final keyword in keywords) {
//       list.add(keyword.id.toString());
//     }
//     return list;
//   }
//
//   List<int> get keywordIds {
//     final ids = <int>[];
//     if (keywordsStringList.isNotEmpty) {
//       for (final keywordString in keywordsStringList) {
//         ids.add(int.parse(keywordString));
//       }
//     }
//     return ids;
//   }
//
//   var search = ''.obs;
//
//   void setSearch(String v) => search(v);
// }
