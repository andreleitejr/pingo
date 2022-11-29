import 'package:pingo/models/selectable.dart';

class Gender extends Selectable {
  final int id;
  final String title;

  Gender(this.id, this.title);

  @override
  bool get enabled => true;

  @override
  String get text => title;
}

class GenderType {
  static const female = 0;
  static const male = 1;
  static const transgender = 2;
  static const other = 3;
}

final genders = [
  Gender(GenderType.female, 'Female'),
  Gender(GenderType.male, 'Male'),
  Gender(GenderType.transgender, 'Transgender'),
  Gender(GenderType.other, 'Other'),
];
