import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/repositories/database_repository.dart';

class PlaceRepository extends DataBaseRepository<Place> {
  PlaceRepository()
      : super(
          fromMap: (document) => Place.fromMap(document),
          name: 'places',
        );
}
