import 'package:pingo/i18n/strings.g.dart';
import 'package:pingo/models/selectable.dart';

class Language implements Selectable {
  final String title;
  final String code;

  const Language(this.title, this.code);

  @override
  bool get enabled => true;

  @override
  String get text => title;
}

class LanguageCode {
  static const portuguese = 'pt';
  static const english = 'en';
  static const spanish = 'es';
}

final languages = <Language>[
  Language(t.languages.portuguese, LanguageCode.portuguese),
  Language(t.languages.english, LanguageCode.english),
  Language(t.languages.spanish, LanguageCode.spanish),
];
