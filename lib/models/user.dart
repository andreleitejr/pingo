import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pingo/models/base.dart';

class User extends Base {
  final DateTime birthday;
  final String email;
  final String gender;
  final String country;
  final String city;
  final bool agreed;

  User({
    required String name,
    required this.birthday,
    required this.email,
    required this.gender,
    required this.country,
    required this.city,
    this.agreed = true,
    String? description,
  }) : super(name: name, description: description);

  User.fromMap(DocumentSnapshot document)
      : birthday = (document['birthday'] as Timestamp).toDate(),
        email = document['email'] as String,
        gender = document['gender'] as String,
        country = document['country'] as String,
        city = document['city'] as String,
        agreed = document['agreed'] as bool,
        super.fromMap(document);

  @override
  Map<String, dynamic> toMap() =>
      super.toMap()
        ..remove('createdBy')
        ..addAll({
          'birthday': birthday,
          'email': email,
          'gender': gender,
          'country': country,
          'city': city,
          'agreed': agreed,
        });
}
