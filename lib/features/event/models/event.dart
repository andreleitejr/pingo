import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/models/buyable.dart';

class Event extends Buyable {
  final String placeId;
  final DateTime start;
  final DateTime end;

  Place? place;

  Event({
    required this.placeId,
    required this.start,
    required this.end,
    required super.price,
    required super.name,
    required super.keywords,
    super.description,
    super.image,
    super.promotionalPrice,
  });

  Event.fromMap(DocumentSnapshot document)
      : placeId = document['placeId'] as String,
        start = (document['start'] as Timestamp).toDate(),
        end = (document['end'] as Timestamp).toDate(),
        super.fromMap(document);

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'placeId': placeId,
        'start': start,
        'end': end,
      });
  }
}
