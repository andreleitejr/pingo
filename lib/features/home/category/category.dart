import 'package:pingo/constants/design_emojis.dart';

class Category {
  final int id;
  final String title;
  final String image;

  // final int keyword;

  Category(this.id, this.title, this.image);

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
  Category(Category.all, 'All', DesignEmojis.all),
  Category(Category.restaurants, 'Restaurant', DesignEmojis.restaurant),
  Category(Category.products, 'Products', DesignEmojis.product),
  Category(Category.events, 'Events', DesignEmojis.eventWoman),
  Category(Category.pubs, 'Pubs', DesignEmojis.pub),
  Category(Category.fastFoods, 'Fast Foods', DesignEmojis.fastFood),
  Category(Category.shopping, 'Shopping', DesignEmojis.shopping),
  Category(Category.theaters, 'Theaters', DesignEmojis.theater),
  Category(Category.museums, 'Museums', DesignEmojis.museum),
  Category(Category.historical, 'Historical Places', DesignEmojis.historical),
  Category(Category.utils, 'Utils', DesignEmojis.utils),
];
