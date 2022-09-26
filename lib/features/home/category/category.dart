
class Category {
  final int id;
  final String title;

  // final int keyword;

  Category(this.id, this.title);

  static const all = 0;
  static const restaurants = 1;
  static const pubs = 2;
  static const events = 3;
  static const products = 4;
  static const fastFoods = 5;
  static const theaters = 6;
  static const museums = 7;
  static const historical = 8;
  static const utils = 9;
}

final categories = [
  Category(Category.all, 'All'),
  Category(Category.restaurants, 'Restaurant'),
  // Category(Category.events, 'Events'),
  Category(Category.pubs, 'Pubs'),
  Category(Category.fastFoods, 'Fast Foods'),
  // Category(Category.products, 'Products'),
  Category(Category.theaters, 'Theaters'),
  Category(Category.museums, 'Museums'),
  Category(Category.historical, 'Historical Places'),
  Category(Category.utils, 'Utils'),
];
