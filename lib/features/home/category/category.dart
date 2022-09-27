class Category {
  final int id;
  final String title;

  // final int keyword;

  Category(this.id, this.title);

  static const all = 0;
  static const restaurants = 1;
  static const pubs = 2;
  static const shopping = 3;
  static const fastFoods = 4;
  static const theaters = 5;
  static const museums = 6;
  static const historical = 7;
  static const utils = 8;

  static const events = 20;
  static const products = 21;
}

final categories = [
  Category(Category.all, 'All'),
  Category(Category.restaurants, 'Restaurant'),
  // Category(Category.events, 'Events'),
  Category(Category.pubs, 'Pubs'),
  Category(Category.shopping, 'Shopping'),
  Category(Category.fastFoods, 'Fast Foods'),
  // Category(Category.products, 'Products'),
  Category(Category.theaters, 'Theaters'),
  Category(Category.museums, 'Museums'),
  Category(Category.historical, 'Historical Places'),
  Category(Category.utils, 'Utils'),
];
