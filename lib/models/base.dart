import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/rating/models/rating.dart';
import 'package:pingo/models/database.dart';
import 'package:pingo/models/image_blurhash.dart';

abstract class Base extends DataBase {
  String name;
  String? description;
  ImageBlurHash? image;
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
        image = document['image'] != null
            ? ImageBlurHash.fromJson(document['image'])
            : null,
        super.fromMap(document);

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'name': name,
        'keywords': keywords,
        'description': description,
        'image': image?.toJson(),
      });
  }

  late double distance;

  void setDistance(double v) => distance = v;

  final ratings = <Rating>[];

  double get rating {
    if (ratings.isEmpty) return 5;

    var i = 0;

    for (final r in ratings) {
      i += r.nps;
    }

    return (i / ratings.length) / 2;
  }

  List<Keyword> get keywordData => allKeywords
      .where((keywordData) => keywords.contains(keywordData.id))
      .toList();
}
