import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/features/event/repositories/event_repository.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/post/models/post.dart';
import 'package:pingo/features/post/repositories/post_repository.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/features/product/repositories/product_repository.dart';
import 'package:pingo/features/rating/models/rating.dart';
import 'package:pingo/repositories/database_repository.dart';
import 'package:pingo/features/rating/repositories/rating_repository.dart';
import 'package:rxdart/rxdart.dart';

class PlaceRepository extends DataBaseRepository<Place> {
  PlaceRepository()
      : super(
          fromMap: (document) => Place.fromMap(document),
          name: 'places',
        );

  final productRepository = ProductRepository();
  final eventRepository = EventRepository();
  final ratingRepository = RatingRepository();
  final postRepository = PostRepository();

  Stream<List<Place>> get combined => Rx.combineLatest5(
        read,
        productRepository.read,
        eventRepository.read,
        ratingRepository.read,
        postRepository.read,
        (
          List<Place> a,
          List<Product> b,
          List<Event> c,
          List<Rating> d,
          List<Post> e,
        ) {
          for (final place in a) {
            final products = b.where(
              (product) => product.placeId == place.uuid,
            );

            place.products.addAll(products);

            for (var product in place.products) {
              final productRatings = d.where(
                (rating) => rating.ratedId == product.uuid,
              );

              product.place = place;

              product.ratings.addAll(productRatings);

              product.setDistance(place.distance);
            }

            final events = c.where(
              (event) => event.placeId == place.uuid,
            );

            place.events.addAll(events);

            for (var event in place.events) {
              final eventRatings = d.where(
                (rating) => rating.ratedId == event.uuid,
              );

              event.place = place;

              event.ratings.addAll(eventRatings);

              event.setDistance(place.distance);
            }

            final ratings = d.where(
              (rating) => rating.ratedId == place.uuid,
            );
            place.ratings.addAll(ratings);

            final posts = e.where(
              (post) => post.placeId == place.uuid,
            );
            place.posts.addAll(posts);
          }
          return a;
        },
      );
}
