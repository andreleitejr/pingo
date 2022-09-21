import 'package:get/get.dart';
import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/place/repositories/place_repository.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/models/user.dart';

class HomeController extends GetxController {
  HomeController();

  final User user = Get.find();

  final repository = PlaceRepository();

  Rx<List<Place>> bestMatchList = Rx<List<Place>>([]);
  Rx<List<Place>> placeList = Rx<List<Place>>([]);

  List<Place> get places {
    final list = placeList.value;

    list.sort((a, b) => a.distance.compareTo(b.distance));

    return list;
  }

  List<Place> get bestMatch {
    final list = bestMatchList.value;

    for (final place in list) {
      final match =
          place.keywords.toSet().intersection(user.keywords.toSet()).length;
      place.match = match;
    }
    list.sort((a, b) => a.compareTo(b));

    return list;
  }

  List<Product> get productBestMatch {
    final products = <Product>[];

    for (final place in placeList.value) {
      products.addAll(place.products);
    }

    for (final product in products) {
      final match =
          product.keywords.toSet().intersection(user.keywords.toSet()).length;
      product.match = match;
    }

    products.sort((a, b) => a.compareTo(b));

    return products;
  }

  List<Event> get eventsBestMatch {
    final events = <Event>[];

    for (final place in placeList.value) {
      events.addAll(place.events);
    }

    print('PRODUCTS: ${events.length}');

    for (final event in events) {
      final match =
          event.keywords.toSet().intersection(user.keywords.toSet()).length;
      event.match = match;
    }
    events.sort((a, b) => a.compareTo(b));
    return events;
  }

  @override
  void onReady() {
    bestMatchList.bindStream(repository.combined);
    placeList.bindStream(repository.combined);
  }
}
