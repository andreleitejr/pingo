import 'package:pingo/models/rating.dart';
import 'package:pingo/repositories/database_repository.dart';

class RatingRepository extends DataBaseRepository<Rating> {
  RatingRepository()
      : super(
    name: 'ratings',
    fromMap: (document) => Rating.fromMap(document),
  );
}
