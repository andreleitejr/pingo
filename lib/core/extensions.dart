import 'package:diacritic/diacritic.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String get pathReference => split("/").last;

  String get clean => removeDiacritics(toLowerCase());

  bool get containsLettersAndNumbers =>
      contains(RegExp(r'[0-9]')) && contains(RegExp(r'[a-z]'));
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
