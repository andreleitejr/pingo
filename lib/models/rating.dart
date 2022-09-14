import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pingo/models/database.dart';

class Rating extends DataBase{
  final String title;
  final String? message;
  final double? grade;
  final String? ratedId;

  Rating({
    required this.title,
    this.message,
    this.grade,
    this.ratedId,
    required String createdBy,
  });

  Rating.fromMap(DocumentSnapshot document)
      : title = document['title'] as String,
        message = document['message'] as String,
        grade = document['grade'] as double,
        ratedId = document['ratedId'] as String,
        super.fromMap(document);

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'title': title,
        'message': message,
        'grade': grade,
        'ratedId': ratedId,
      });
  }
}
