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
      : birthday = document['birthday'],
        email = document['email'],
        gender = document['gender'],
        country = document['country'],
        city = document['city'],
        agreed = document['agreed'],
        super.fromMap(document);

  @override
  Map<String, dynamic> toMap() => {
        'name': name,
        'birthday': birthday,
        'email': email,
        'gender': gender,
        'country': country,
        'city': city,
        'image': image,
        'description': description,
        'agreed': agreed,
      };
}
