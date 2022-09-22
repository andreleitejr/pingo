import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pingo/features/rating/models/rating.dart';
import 'package:pingo/models/database.dart';

abstract class Base extends DataBase {
  final String name;
  final String? description;
  final String? image;
  final List<int> keywords;

  Base({
    required this.name,
    required this.keywords,
    this.description,
    this.image,
  });

  Base.fromMap(DocumentSnapshot document)
      : name = document['name'] as String,
        keywords = List.from(document['keywords']),
        description = document['description'] as String?,
        image = document['image'] as String?,
        super.fromMap(document);

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'name': name,
        'keywords': keywords,
        'description': description,
        'image': image,
      });
  }

  late double distance;

  void setDistance(double v) => distance = v;

  int? match;

  int compareTo(Base other) {
    // TODO: SUBSTITUIR PELA MAX DISTANCE DO FILTRO
    if (distance <= 1000 && other.distance <= 1000) {
      if (match == other.match) return distance.compareTo(other.distance);
      return match!.compareTo(other.match!) * -1;
    } else {
      return distance.compareTo(other.distance);

      // if (match == other.match) return distance.compareTo(other.distance);
    }
  }

  final ratings = <Rating>[];

  double get rating {
    var i = 0;
    for (final r in ratings) {
      i += r.nps;
    }

    return (i / ratings.length) / 2;
  }
}
