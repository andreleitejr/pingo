class ProductCategory {
  final String title;
  final int id;

  ProductCategory(this.title, this.id);

  static const food = 0;
  static const drink = 1;
  static const fashion = 2;
  static const utils = 3;
  static const medicine = 4;
  static const miscellaneous = 5;
}

final productTypes = [
  ProductCategory('Foods', ProductCategory.food),
  ProductCategory('Drinks', ProductCategory.drink),
  ProductCategory('Fashion', ProductCategory.fashion),
  ProductCategory('Utils', ProductCategory.utils),
  ProductCategory('Medicine', ProductCategory.medicine),
  ProductCategory('Miscellaneous', ProductCategory.miscellaneous),
];
