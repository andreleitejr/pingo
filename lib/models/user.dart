import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pingo/models/database.dart';

class User extends DataBase {
  final String name;
  final DateTime birthday;
  final String email;
  final String gender;
  final String country;
  final String city;
  final String? image;
  final String? description;
  final bool agreed;

  User({
    required this.name,
    required this.birthday,
    required this.email,
    required this.gender,
    required this.country,
    required this.city,
    this.image,
    this.description,
    this.agreed = true,
  }) : super();

  factory User.fromMap(DocumentSnapshot document) {
    return User(
      name: document['name'],
      birthday: document['birthday'],
      email: document['email'],
      gender: document['gender'],
      country: document['country'],
      city: document['city'],
      agreed: document['agreed'],
    );
  }

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
