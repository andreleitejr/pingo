import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pingo/models/database.dart';

class Message extends DataBase {
  final String recipientId;
  final String message;
  String createdBy;

  Message({
    required this.recipientId,
    required this.message,
    required this.createdBy,
  });

  Message.fromMap(DocumentSnapshot document)
      : recipientId = document['recipientId'] as String,
        message = document['message'] as String,
        createdBy = document['createdBy'] as String,
        super.fromMap(document);

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'recipientId': recipientId,
        'message': message,
        'createdBy': createdBy,
      });
  }
}
