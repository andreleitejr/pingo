import 'package:pingo/features/auth/models/city.dart';
import 'package:pingo/models/selectable.dart';

class Province extends Selectable {
  final int id;
  final String name;
  final String stateCode;
  final double latitude;
  final double longitude;
  final String? type;
  final List<City> cities;

  Province({
    required this.id,
    required this.name,
    required this.stateCode,
    required this.latitude,
    required this.longitude,
    this.type,
    required this.cities,
  });

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json['id'] as int,
        name: json['name'] as String? ?? '',
        stateCode: json['stateCode'] as String? ?? '',
        latitude: double.tryParse(json['latitude'] as String? ?? '') ?? 0,
        longitude: double.tryParse(json['longitude'] as String? ?? '') ?? 0,
        type: json['type'] as String?,
        cities: (json['cities'] as List)
            .map((data) => City.fromJson(data))
            .toList(),
      );

  static const defaultProvince = 2021;

  @override
  bool get enabled => true;

  @override
  String get text => name;
}
