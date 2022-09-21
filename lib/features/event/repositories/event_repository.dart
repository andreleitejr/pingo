import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/repositories/database_repository.dart';

class EventRepository extends DataBaseRepository<Event> {
  EventRepository()
      : super(
          fromMap: (document) => Event.fromMap(document),
          name: 'events',
        );
}
