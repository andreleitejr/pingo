import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diacritic/diacritic.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:pingo/constants/emails.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/auth/repositories/auth_repository.dart';

extension StringExtension on String {
  String get pathReference => split("/").last;

  String get pathName => replaceAll(' ', '-').toLowerCase();

  String get clean => removeDiacritics(toLowerCase());

  bool get passwordValid =>
      length >= 6 &&
      contains(RegExp(r'[0-9]')) &&
      contains(RegExp(r'[a-z]')) &&
      contains(RegExp(r'[^a-z]'));
}

extension IntExtension on int {
  String get keyword {
    final keywords = placesKeywords + foods + musics + miscellaneous;

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
  String get yMMMMd => DateFormat.yMMMMd('en_US').format(this);
  String get jm => DateFormat.jm('en_US').format(this);

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

  String startAndEnd(DateTime end) =>
      '$hour${minute != 0 ? ':$minute' : ''} - ${end.hour}${end.minute != 0 ? ':${end.minute}' : ''}';
}

extension PositionExtension on Position {
  GeoPoint get toGeoPoint => GeoPoint(latitude, longitude);
}

extension AuthResultExtension on AuthResult {
  String get title {
    if (this == AuthResult.emailAlreadyInUse) {
      return 'E-mail already in use';
    } else if (this == AuthResult.weakPassword) {
      return 'Password is too weak';
    } else if (this == AuthResult.wrongPassword) {
      return 'Wrong password';
    } else if (this == AuthResult.userNotFound) {
      return 'User not registered';
    }
    return 'Unexpected error';
  }

  String get message {
    if (this == AuthResult.emailAlreadyInUse) {
      return 'E-mail already in use. Please try another e-mail.';
    } else if (this == AuthResult.weakPassword) {
      return 'This password is too weak. Try a password with unless 6 letters and numbers';
    } else if (this == AuthResult.wrongPassword) {
      return 'Looks like you entered a wrong password. Please, try again.';
    } else if (this == AuthResult.userNotFoundInDatabase) {
      return 'User not found in database. We are redirecting your...';
    } else if (this == AuthResult.userNotFound) {
      return 'You don\'t have an account yet. Please sign up.';
    } else if (this == AuthResult.tooManyRequests) {
      return 'Too many requests detected. Please, try again in a few minutes.';
    }
    return 'An unexpected error occurred. Try again in minutes or try contact our support at ${Emails.support}';
  }
}
