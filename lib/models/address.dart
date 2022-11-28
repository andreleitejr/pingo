import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  final String city;
  final String? complement;
  final String country;
  final String? line;
  final GeoPoint location;
  final String? subLocality;
  final String number;
  final String? state;
  final String? zip;

  Address({
    required this.city,
    required this.country,
    required this.number,
    required this.location,
    this.complement,
    this.line,
    this.subLocality,
    this.state,
    this.zip,
  });

  Address.fromJson(Map<String, dynamic> json)
      : city = json['city'],
        complement = json['complement'],
        country = json['country'],
        line = json['line'],
        location = json['location'],
        subLocality = json['neighborhood'],
        number = json['number'],
        state = json['state'],
        zip = json['zip'];

  Map<String, dynamic> toJson() => {
    'city': city,
    'complement': complement,
    'country': country,
    'line': line,
    'location': location,
    'neighborhood': subLocality,
    'number': number,
    'state': state,
    'zip': zip,
  };
}