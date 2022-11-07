import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pingo/features/message/models/message.dart';
import 'package:pingo/models/database.dart';
import 'package:pingo/services/blurhash_controller.dart';

class Post extends DataBase {
  final String placeId;
  final String description;
  final ImageBlurHash? image;
  String createdBy;
  List<Message>? messages;

  Post({
    required this.placeId,
    required this.description,
    required this.image,
    required this.createdBy,
    this.messages,
  });

  Post.fromMap(DocumentSnapshot document)
      : placeId = document['placeId'] as String,
        description = document['description'] as String,
        image =
            ImageBlurHash.fromJson(document['image'] as Map<String, dynamic>),
        createdBy = document['createdBy'] as String,
        super.fromMap(document);

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'placeId': placeId,
        'description': description,
        'image': image?.toJson(),
        'createdBy': createdBy,
      });
  }
}
