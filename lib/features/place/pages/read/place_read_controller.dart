import 'package:get/get.dart';

enum PlaceTabItemValue { photos, map, ratings }

class PlaceReadController extends GetxController {
  var currentTab = PlaceTabItemValue.photos.obs;

  void setTabItem(PlaceTabItemValue v) => currentTab(v);
}
