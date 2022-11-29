import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pingo/models/base.dart';

class User extends Base {
  final DateTime birthday;
  final String email;
  final String gender;
  final String sexualOrientation;
  final String country;
  final String province;
  final String city;
  final bool agreed;
  String? nickname;

  User({
    required super.name,
    required this.birthday,
    required this.email,
    required this.gender,
    required this.sexualOrientation,
    required this.country,
    required this.province,
    required this.city,
    this.agreed = true,
    this.nickname,
    super.description,
    super.image,
    required super.keywords,
  });

  User.fromMap(DocumentSnapshot document)
      : birthday = (document['birthday'] as Timestamp).toDate(),
        email = document['email'] as String,
        gender = document['gender'] as String,
        sexualOrientation = document['sexualOrientation'] as String,
        country = document['country'] as String,
        province = document['state'] as String,
        city = document['city'] as String,
        agreed = document['agreed'] as bool,
        nickname = document['nickname'] as String?,
        super.fromMap(document);

  @override
  Map<String, dynamic> toMap() => super.toMap()
    ..remove('createdBy')
    ..addAll({
      'birthday': birthday,
      'email': email,
      'gender': gender,
      'sexualOrientation': sexualOrientation,
      'country': country,
      'state': province,
      'city': city,
      'agreed': agreed,
      'nickname': nickname,
    });
}
