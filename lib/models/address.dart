import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  final String city;
  final String? complement;
  final String country;
  final String? line;
  final GeoPoint location;
  final String? neighborhood;
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
    this.neighborhood,
    this.state,
    this.zip,
  });

  Address.fromJson(Map<String, dynamic> json)
      : city = json['city'],
        complement = json['complement'],
        country = json['country'],
        line = json['line'],
        location = json['location'],
        neighborhood = json['neighborhood'],
        number = json['number'],
        state = json['state'],
        zip = json['zip'];

  Map<String, dynamic> toJson() => {
    'city': city,
    'complement': complement,
    'country': country,
    'line': line,
    'location': location,
    'neighborhood': neighborhood,
    'number': number,
    'state': state,
    'zip': zip,
  };
}

List<Address> addresses = [
  Address(
    city: 'São Paulo',
    complement: '',
    country: 'Brazil',
    line: 'Praça Franklin Roosevelt',
    location: const GeoPoint(-23.5487885,-46.646209),
    neighborhood: 'Centro Histórico de São Paulo',
    number: '2',
    state: 'São Paulo',
    zip: '01120010',
  ),
];
