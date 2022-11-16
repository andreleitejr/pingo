import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/home/base_page.dart';
import 'package:pingo/models/category.dart';
import 'package:pingo/services/current_location.dart';
import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/services/category_controller.dart';
import 'package:pingo/features/home/components/filter/filter_controller.dart';
import 'package:pingo/features/home/components/search/search_controller.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/place/repositories/place_repository.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/services/current_weather.dart';

class HomeController extends GetxController {
  HomeController(this.pageNav) {
    loading(true);
  }

  final BasePageNav pageNav;

  var selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex(index);
  }

  var loading = false.obs;

  final User user = Get.find();

  final location = Get.put(CurrentLocation());

  final weather = Get.put(CurrentWeather());

  final internet = (Get.put(InternetConnectionChecker()));

  final repository = PlaceRepository();

  final filter = Get.put(FilterController());

  final search = Get.put(SearchController());

  final category = Get.put(CategoryController());

  Rx<List<Place>> bestMatchList = Rx<List<Place>>([]);
  Rx<List<Place>> placeList = Rx<List<Place>>([]);

  List<Place> get places {
    var list = placeList.value;

    list.sort((a, b) => a.distance.compareTo(b.distance));

    list = filter.filterPlaceByDistance(list) as List<Place>;
    list = filter.filterPlaceByRating(list) as List<Place>;
    list = search.filterBySearch(list) as List<Place>;
    list = category.filterByCategory(list) as List<Place>;
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
    // list = filter.filterPlaceByRating(list) as List<Place>;
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
    // products = filter.filterPlaceByRating(products) as List<Product>;
    products = filter.filterProductByPrice(products) as List<Product>;

    products = search.filterBySearch(products) as List<Product>;
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
    // events = filter.filterPlaceByRating(events) as List<Event>;
    events = filter.filterProductByPrice(events) as List<Event>;
    events = search.filterBySearch(events) as List<Event>;
    return events;
  }

  Future<void> _verifyConnection() async {
    final hasConnection = await internet.hasConnection;

    if (!hasConnection) {
      await Future.delayed(const Duration(milliseconds: 500));
      pageNav.noInternetConnection();
    }
  }

  Future<void> _getLocation() async {
    final permission = await location.requestPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Future.delayed(const Duration(milliseconds: 750));
      pageNav.locationDenied();
    }
  }

  @override
  Future<void> onReady() async {
    bestMatchList.bindStream(repository.combined);
    placeList.bindStream(repository.combined);
  }

  // var coordinates = const GeoPoint(0, 0).obs;
  var address = ''.obs;
  var temperature = 25.obs;
  var icon = ''.obs;
  var generalCategories = <Category>[].obs;
  var placeCategories = <Category>[].obs;

  @override
  Future<void> onInit() async {
    await _verifyConnection();
    await _getLocation();

    await location.init();
    // coordinates(location.currentCoordinates);
    address(location.currentAddress);

    await weather.init();
    temperature(weather.weather?.temperature?.celsius?.round());
    icon(weather.icon);

    final general = category.get(CategoryType.general);
    generalCategories(general);

    // final places = category.get(CategoryType.places);
    // placeCategories(places);

    loading(false);

    super.onInit();
  }
}
