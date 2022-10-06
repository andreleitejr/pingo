import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pingo/models/database.dart';
import 'package:pingo/models/user.dart';

class Rating extends DataBase {
  String? message;
  String? title;
  String? image;
  int nps;
  String ratedId;
  String ratedBy;

  Rating({
    required this.nps,
    this.message,
    this.image,
    this.title,
    required this.ratedId,
    required this.ratedBy
  });

  Rating.fromMap(DocumentSnapshot document)
      : nps = document['nps'] as int,
        message = document['message'] as String,
        title = document['title'] as String,
        image = document['image'] as String,
        ratedId = document['ratedId'] as String,
        ratedBy = document['ratedBy'] as String,
        super.fromMap(document);

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'message': message,
        'title': title,
        'image': image,
        'nps': nps,
        'ratedId': ratedId,
        'ratedBy': ratedBy,
      });
  }
}
