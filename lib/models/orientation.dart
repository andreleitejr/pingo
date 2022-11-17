import 'package:pingo/models/selectable.dart';

class SexualOrientation extends Selectable {
  final int id;
  final String title;

  SexualOrientation(this.id, this.title);

  @override
  bool get enabled => true;

  @override
  String get text => title;
}

class SexualOrientationType {
  static const hetero = 0;
  static const gay = 1;
  static const lesbian = 2;
  static const bisexual = 3;
  static const pansexual = 4;
  static const other = 5;
}

final sexualOrientations = [
  SexualOrientation(SexualOrientationType.hetero, 'Hetero'),
  SexualOrientation(SexualOrientationType.gay, 'Gay'),
  SexualOrientation(SexualOrientationType.lesbian, 'Lesbian'),
  SexualOrientation(SexualOrientationType.bisexual, 'Bisexual'),
  SexualOrientation(SexualOrientationType.pansexual, 'Pansexual'),
  SexualOrientation(SexualOrientationType.other, 'Other'),
];
