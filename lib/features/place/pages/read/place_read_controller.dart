import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:share_plus/share_plus.dart';

enum PlaceTabItemValue { photos, map, ratings }

class PlaceReadController extends GetxController {
  PlaceReadController(this.place, {required this.vsync});

  final TickerProvider vsync;
  late TabController tabController;

  int get tabLength {
    int i = 5;
    if (place.posts.isEmpty) {
      i--;
    }
    if (place.events.isEmpty) {
      i--;
    }
    if (place.products.isEmpty) {
      i--;
    }
    if (place.ratings.isEmpty) {
      i--;
    }
    return i;
  }

  Place place;

  var isMasonry = false.obs;

  void toggleMasonry() => isMasonry(!isMasonry.value);

  @override
  Future<void> onInit() async {
    tabController = TabController(length: tabLength, vsync: vsync);

    super.onInit();
  }

  Future<void> share() async {
    await Share.share(
      'Check out this great place I found.',
      subject: place.name,
    );
  }
}
