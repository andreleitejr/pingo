import 'package:get/get.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/features/home/category/category.dart';
import 'package:pingo/features/home/filter/filter_controller.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/place/repositories/place_repository.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/models/user.dart';

class HomeController extends GetxController {
  HomeController();

  final User user = Get.find();

  final repository = PlaceRepository();

  final filter = Get.put(FilterController());

  Rx<List<Place>> bestMatchList = Rx<List<Place>>([]);
  Rx<List<Place>> placeList = Rx<List<Place>>([]);

  List<Place> get places {
    var list = placeList.value;

    list.sort((a, b) => a.distance.compareTo(b.distance));

    list = filter.filterPlaceByDistance(list) as List<Place>;
    list = filter.filterPlaceByRating(list) as List<Place>;
    return list;
  }

  List<Place> get bestMatch {
    var list = bestMatchList.value;

    for (final place in list) {
      final match =
          place.keywords.toSet().intersection(user.keywords.toSet()).length;
      place.match = match;
    }
    list.sort((a, b) => a.compareTo(b));

    list = filter.filterPlaceByDistance(list) as List<Place>;
    list = filter.filterPlaceByRating(list) as List<Place>;
    return list;
  }

  List<Product> get productBestMatch {
    var products = <Product>[];

    for (final place in placeList.value) {
      products.addAll(place.products);
    }

    for (final product in products) {
      final match =
          product.keywords.toSet().intersection(user.keywords.toSet()).length;
      product.match = match;
    }

    products.sort((a, b) => a.compareTo(b));

    products = filter.filterPlaceByDistance(products) as List<Product>;
    products = filter.filterPlaceByRating(products) as List<Product>;
    products = filter.filterProductByPrice(products) as List<Product>;

    return products;
  }

  List<Event> get eventsBestMatch {
    var events = <Event>[];

    for (final place in placeList.value) {
      events.addAll(place.events);
    }

    for (final event in events) {
      final match =
          event.keywords.toSet().intersection(user.keywords.toSet()).length;
      event.match = match;
    }

    events.sort((a, b) => a.compareTo(b));

    events = filter.filterPlaceByDistance(events) as List<Event>;
    events = filter.filterPlaceByRating(events) as List<Event>;
    events = filter.filterProductByPrice(events) as List<Event>;

    return events;
  }

  @override
  void onReady() {
    bestMatchList.bindStream(repository.combined);
    placeList.bindStream(repository.combined);
  }

  List<Place> _build(List<int> keywords) {
    return places
        .where((place) =>
        place.keywords.any((keyword) => keywords.contains(keyword)))
        .toList();
  }

  List<Place> get restaurants => _build([Keyword.restaurant]);

  List<Place> get pubs => _build([Keyword.pub]);

  List<Place> get fastFoods => _build([Keyword.fastFood]);

  List<Place> get museums => _build([Keyword.museum]);

  List<Place> get theaters => _build([Keyword.theater]);

  List<Place> get parks => _build([Keyword.park]);

  List<Place> get historical => _build([Keyword.historical]);

  List<Place> get utils => _build([
    Keyword.police,
    Keyword.fireDepartment,
    Keyword.hospital,
    Keyword.emergency,
  ]);

  List<Category> get categories => [
    Category('Restaurant', restaurants),
    // Category('Events', events),
    Category('Pubs', pubs),
    Category('Fast Foods', fastFoods),
    // Category('Products', restaurants),
    Category('Theaters', theaters),
    Category('Museums', museums),
    Category('Historicals', historical),
    Category('Utils', utils),
  ];
}
