import 'package:diacritic/diacritic.dart';

extension StringExtension on String {
  String get pathReference => split("/").last;

  String get clean => removeDiacritics(toLowerCase());

  bool get containsLettersAndNumbers =>
      contains(RegExp(r'[0-9]')) && contains(RegExp(r'[a-z]'));
}
