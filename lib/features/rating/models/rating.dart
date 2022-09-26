import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pingo/models/database.dart';

class Rating extends DataBase {
  String? message;
  int nps;
  String? ratedId;

  Rating({
    required this.nps,
    this.message,
    this.ratedId,
  });

  Rating.fromMap(DocumentSnapshot document)
      : nps = document['nps'] as int,
        message = document['message'] as String,
        ratedId = document['ratedId'] as String,
        super.fromMap(document);

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'message': message,
        'nps': nps,
        'ratedId': ratedId,
      });
  }
}
