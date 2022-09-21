import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/repositories/database_repository.dart';

class ProductRepository extends DataBaseRepository<Product> {
  ProductRepository()
      : super(
          fromMap: (document) => Product.fromMap(document),
          name: 'products',
        );
}
