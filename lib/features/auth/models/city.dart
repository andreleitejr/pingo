import 'package:pingo/models/selectable.dart';

class City extends Selectable {
  final int id;
  final String name;
  final double latitude;
  final double longitude;

  City(
      {required this.id,
      required this.name,
      required this.latitude,
      required this.longitude});

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json['id'] as int,
        name: json['name'] as String? ?? '',
        latitude: double.tryParse(json['latitude'] as String) ?? 0,
        longitude: double.tryParse(json['longitude'] as String) ?? 0,
      );

  static const saoPaulo = 15101;

  @override
  bool get enabled => true;

  @override
  String get text => name;
}
