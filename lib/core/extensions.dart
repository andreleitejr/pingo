import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diacritic/diacritic.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:pingo/core/keyword.dart';

extension StringExtension on String {
  String get pathReference => split("/").last;

  String get clean => removeDiacritics(toLowerCase());

  bool get containsLettersAndNumbers =>
      contains(RegExp(r'[0-9]')) && contains(RegExp(r'[a-z]'));
}

extension IntExtension on int {
  String get keyword {
    final keywords = places + foods + musics + miscellaneous;

    return keywords.firstWhere((keyword) => keyword.id == this).title;
  }
}

extension DoubleExtension on double {
  double get km => this / 1000;

  String get time {
    if (this < 0) return 'Invalid Value';
    final flooredValue = floor();
    final decimalValue = this - flooredValue;
    final hourValue = getHourString(flooredValue);
    final minuteString = getMinuteString(decimalValue);

    return '$hourValue:$minuteString';
  }

  num get doubleWithoutDecimalToInt {
    return this % 1 == 0 ? toInt() : this;
  }

  String get metricSystem {
    if (this < 1000) {
      return '${doubleWithoutDecimalToInt.floor()}m';
    } else {
      return '${(this / 1000).doubleWithoutDecimalToInt.toStringAsFixed(1)}km';
    }
  }

  String get monetary => NumberFormat.simpleCurrency().format(this);

  String getMinuteString(double decimalValue) {
    return '${(decimalValue * 60).toInt()}'.padLeft(2, '0');
  }

  String getHourString(int flooredValue) {
    return '${flooredValue % 24}'.padLeft(2, '0');
  }
}

extension DateTimeExtension on DateTime {
  String get format => DateFormat.yMMMMd('en_US').format(this);

  bool get acceptedAge {
    const minAge = 18;
    final today = DateTime.now();

    final differenceInYears = today.year - year;
    final differenceInMonths = today.month - month;
    final differenceInDays = today.day - day;

    return differenceInYears > minAge ||
        differenceInMonths == minAge &&
            differenceInDays >= 0 &&
            differenceInDays >= 0;
  }
}

extension PositionExtension on Position {
  GeoPoint get toGeoPoint => GeoPoint(latitude, longitude);
}
