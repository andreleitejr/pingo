import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pingo/models/database.dart';

abstract class Base extends DataBase {
  final String name;
  final String? description;
  final String? image;
  final String? createdBy;

  Base({
    required this.name,
    this.description,
    this.image,
    this.createdBy,
  });

  Base.fromMap(DocumentSnapshot document)
      : name = document['name'] as String,
        description = document['description'] as String?,
        image = document['image'] as String,
        createdBy = document['createdBy'] as String,
        super.fromMap(document);

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'name': name,
        'description': description,
        'image': image,
        'createdBy': createdBy,
      });
  }

  double? distance;

  void setDistance(double v) => distance = v;
}
