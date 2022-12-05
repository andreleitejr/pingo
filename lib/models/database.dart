import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DataBase {
  DateTime? createdAt;
  DateTime? updatedAt;
  String uuid;

  DataBase({
    this.createdAt,
    this.updatedAt,
    this.uuid = '',
  });

  DataBase.fromMap(DocumentSnapshot document)
      : createdAt = (document['createdAt'] as Timestamp).toDate(),
        updatedAt = (document['updatedAt'] as Timestamp).toDate(),
        uuid = document.id;

  Map<String, dynamic> toMap() {
    return {
      // TODO: CHANGE
      'createdAt': createdAt, // createdAt,
      'updatedAt': updatedAt, //updatedAt,
    };
  }
}
