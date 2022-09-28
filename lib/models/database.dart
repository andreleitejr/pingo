import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DataBase {
  final DateTime? createdAt;
  final DateTime? updatedAt;
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
      'createdAt': DateTime.now(), // createdAt,
      'updatedAt': DateTime.now(), //updatedAt,
    };
  }
}
