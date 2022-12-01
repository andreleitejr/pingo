
/*
 * Generated file. Do not edit.
 *
 * Locales: 3
 * Strings: 54 (18.0 per locale)
 *
 * Built on 2022-12-01 at 18:55 UTC
 */

import 'package:flutter/widgets.dart';

const AppLocale _baseLocale = AppLocale.en;
AppLocale _currLocale = _baseLocale;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale {
	en, // 'en' (base locale, fallback)
	es, // 'es'
	pt, // 'pt'
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
_StringsEn _t = _currLocale.translations;
_StringsEn get t => _t;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class Translations {
	Translations._(); // no constructor

	static _StringsEn of(BuildContext context) {
		final inheritedWidget = context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
		if (inheritedWidget == null) {
			throw 'Please wrap your app with "TranslationProvider".';
		}
		return inheritedWidget.translations;
	}
}

class LocaleSettings {
	LocaleSettings._(); // no constructor

	/// Uses locale of the device, fallbacks to base locale.
	/// Returns the locale which has been set.
	static AppLocale useDeviceLocale() {
		final locale = AppLocaleUtils.findDeviceLocale();
		return setLocale(locale);
	}

	/// Sets locale
	/// Returns the locale which has been set.
	static AppLocale setLocale(AppLocale locale) {
		_currLocale = locale;
		_t = _currLocale.translations;

		// force rebuild if TranslationProvider is used
		_translationProviderKey.currentState?.setLocale(_currLocale);

		return _currLocale;
	}

	/// Sets locale using string tag (e.g. en_US, de-DE, fr)
	/// Fallbacks to base locale.
	/// Returns the locale which has been set.
	static AppLocale setLocaleRaw(String rawLocale) {
		final locale = AppLocaleUtils.parse(rawLocale);
		return setLocale(locale);
	}

	/// Gets current locale.
	static AppLocale get currentLocale {
		return _currLocale;
	}

	/// Gets base locale.
	static AppLocale get baseLocale {
		return _baseLocale;
	}

	/// Gets supported locales in string format.
	static List<String> get supportedLocalesRaw {
		return AppLocale.values
			.map((locale) => locale.languageTag)
			.toList();
	}

	/// Gets supported locales (as Locale objects) with base locale sorted first.
	static List<Locale> get supportedLocales {
		return AppLocale.values
			.map((locale) => locale.flutterLocale)
			.toList();
	}
}

/// Provides utility functions without any side effects.
class AppLocaleUtils {
	AppLocaleUtils._(); // no constructor

	/// Returns the locale of the device as the enum type.
	/// Fallbacks to base locale.
	static AppLocale findDeviceLocale() {
		final String? deviceLocale = WidgetsBinding.instance.window.locale.toLanguageTag();
		if (deviceLocale != null) {
			final typedLocale = _selectLocale(deviceLocale);
			if (typedLocale != null) {
				return typedLocale;
			}
		}
		return _baseLocale;
	}

	/// Returns the enum type of the raw locale.
	/// Fallbacks to base locale.
	static AppLocale parse(String rawLocale) {
		return _selectLocale(rawLocale) ?? _baseLocale;
	}
}

// context enums

// interfaces generated as mixins

// translation instances

late _StringsEn _translationsEn = _StringsEn.build();
late _StringsEs _translationsEs = _StringsEs.build();
late _StringsPt _translationsPt = _StringsPt.build();

// extensions for AppLocale

extension AppLocaleExtensions on AppLocale {

	/// Gets the translation instance managed by this library.
	/// [TranslationProvider] is using this instance.
	/// The plural resolvers are set via [LocaleSettings].
	_StringsEn get translations {
		switch (this) {
			case AppLocale.en: return _translationsEn;
			case AppLocale.es: return _translationsEs;
			case AppLocale.pt: return _translationsPt;
		}
	}

	/// Gets a new translation instance.
	/// [LocaleSettings] has no effect here.
	/// Suitable for dependency injection and unit tests.
	///
	/// Usage:
	/// final t = AppLocale.en.build(); // build
	/// String a = t.my.path; // access
	_StringsEn build() {
		switch (this) {
			case AppLocale.en: return _StringsEn.build();
			case AppLocale.es: return _StringsEs.build();
			case AppLocale.pt: return _StringsPt.build();
		}
	}

	String get languageTag {
		switch (this) {
			case AppLocale.en: return 'en';
			case AppLocale.es: return 'es';
			case AppLocale.pt: return 'pt';
		}
	}

	Locale get flutterLocale {
		switch (this) {
			case AppLocale.en: return const Locale.fromSubtags(languageCode: 'en');
			case AppLocale.es: return const Locale.fromSubtags(languageCode: 'es');
			case AppLocale.pt: return const Locale.fromSubtags(languageCode: 'pt');
		}
	}
}

extension StringAppLocaleExtensions on String {
	AppLocale? toAppLocale() {
		switch (this) {
			case 'en': return AppLocale.en;
			case 'es': return AppLocale.es;
			case 'pt': return AppLocale.pt;
			default: return null;
		}
	}
}

// wrappers

GlobalKey<_TranslationProviderState> _translationProviderKey = GlobalKey<_TranslationProviderState>();

class TranslationProvider extends StatefulWidget {
	TranslationProvider({required this.child}) : super(key: _translationProviderKey);

	final Widget child;

	@override
	_TranslationProviderState createState() => _TranslationProviderState();

	static _InheritedLocaleData of(BuildContext context) {
		final inheritedWidget = context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
		if (inheritedWidget == null) {
			throw 'Please wrap your app with "TranslationProvider".';
		}
		return inheritedWidget;
	}
}

class _TranslationProviderState extends State<TranslationProvider> {
	AppLocale locale = _currLocale;

	void setLocale(AppLocale newLocale) {
		setState(() {
			locale = newLocale;
		});
	}

	@override
	Widget build(BuildContext context) {
		return _InheritedLocaleData(
			locale: locale,
			child: widget.child,
		);
	}
}

class _InheritedLocaleData extends InheritedWidget {
	final AppLocale locale;
	Locale get flutterLocale => locale.flutterLocale; // shortcut
	final _StringsEn translations; // store translations to avoid switch call

	_InheritedLocaleData({required this.locale, required Widget child})
		: translations = locale.translations, super(child: child);

	@override
	bool updateShouldNotify(_InheritedLocaleData oldWidget) {
		return oldWidget.locale != locale;
	}
}

// pluralization feature not used

// helpers

final _localeRegex = RegExp(r'^([a-z]{2,8})?([_-]([A-Za-z]{4}))?([_-]?([A-Z]{2}|[0-9]{3}))?$');
AppLocale? _selectLocale(String localeRaw) {
	final match = _localeRegex.firstMatch(localeRaw);
	AppLocale? selected;
	if (match != null) {
		final language = match.group(1);
		final country = match.group(5);

		// match exactly
		selected = AppLocale.values
			.cast<AppLocale?>()
			.firstWhere((supported) => supported?.languageTag == localeRaw.replaceAll('_', '-'), orElse: () => null);

		if (selected == null && language != null) {
			// match language
			selected = AppLocale.values
				.cast<AppLocale?>()
				.firstWhere((supported) => supported?.languageTag.startsWith(language) == true, orElse: () => null);
		}

		if (selected == null && country != null) {
			// match country
			selected = AppLocale.values
				.cast<AppLocale?>()
				.firstWhere((supported) => supported?.languageTag.contains(country) == true, orElse: () => null);
		}
	}
	return selected;
}

// translations

// Path: <root>
class _StringsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEn.build();

	/// Access flat map
	dynamic operator[](String key) => _flatMap[key];

	// Internal flat map initialized lazily
	late final Map<String, dynamic> _flatMap = _buildFlatMap();

	late final _StringsEn _root = this; // ignore: unused_field

	// Translations
	String get code => 'en';
	late final _StringsLanguagesEn languages = _StringsLanguagesEn._(_root);
	late final _StringsCommonEn common = _StringsCommonEn._(_root);
	late final _StringsHomeEn home = _StringsHomeEn._(_root);
}

// Path: languages
class _StringsLanguagesEn {
	_StringsLanguagesEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get portuguese => 'Portuguese';
	String get english => 'English';
	String get spanish => 'Spanish';
}

// Path: common
class _StringsCommonEn {
	_StringsCommonEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	late final _StringsCommonDaysOfTheWeekEn daysOfTheWeek = _StringsCommonDaysOfTheWeekEn._(_root);
	late final _StringsCommonMessagesEn messages = _StringsCommonMessagesEn._(_root);
	late final _StringsCommonFieldsEn fields = _StringsCommonFieldsEn._(_root);
	late final _StringsCommonGendersEn genders = _StringsCommonGendersEn._(_root);
}

// Path: home
class _StringsHomeEn {
	_StringsHomeEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	late final _StringsHomeFieldsEn fields = _StringsHomeFieldsEn._(_root);
}

// Path: common.daysOfTheWeek
class _StringsCommonDaysOfTheWeekEn {
	_StringsCommonDaysOfTheWeekEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get sunday => 'Domingo';
	String get monday => 'Segunda-feira';
	String get tuesday => 'Terça-feira';
	String get wednesday => 'Quarta-feira';
	String get thursday => 'Quinta-feira';
	String get friday => 'Sexta-feira';
	String get saturday => 'Sábado';
}

// Path: common.messages
class _StringsCommonMessagesEn {
	_StringsCommonMessagesEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get example => 'Example';
}

// Path: common.fields
class _StringsCommonFieldsEn {
	_StringsCommonFieldsEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get example => 'Example';
}

// Path: common.genders
class _StringsCommonGendersEn {
	_StringsCommonGendersEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Gênero';
	String get hint => 'Selecione o gênero';
	String get male => 'Masculino';
	String get female => 'Feminino';
}

// Path: home.fields
class _StringsHomeFieldsEn {
	_StringsHomeFieldsEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get example => 'Example';
}

// Path: <root>
class _StringsEs implements _StringsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEs.build();

	/// Access flat map
	@override dynamic operator[](String key) => _flatMap[key];

	// Internal flat map initialized lazily
	@override late final Map<String, dynamic> _flatMap = _buildFlatMap();

	@override late final _StringsEs _root = this; // ignore: unused_field

	// Translations
	@override String get code => 'en-us';
	@override late final _StringsLanguagesEs languages = _StringsLanguagesEs._(_root);
	@override late final _StringsCommonEs common = _StringsCommonEs._(_root);
	@override late final _StringsHomeEs home = _StringsHomeEs._(_root);
}

// Path: languages
class _StringsLanguagesEs implements _StringsLanguagesEn {
	_StringsLanguagesEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get portuguese => 'Português';
	@override String get english => 'Inglês';
	@override String get spanish => 'Espanhol';
}

// Path: common
class _StringsCommonEs implements _StringsCommonEn {
	_StringsCommonEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override late final _StringsCommonDaysOfTheWeekEs daysOfTheWeek = _StringsCommonDaysOfTheWeekEs._(_root);
	@override late final _StringsCommonMessagesEs messages = _StringsCommonMessagesEs._(_root);
	@override late final _StringsCommonFieldsEs fields = _StringsCommonFieldsEs._(_root);
	@override late final _StringsCommonGendersEs genders = _StringsCommonGendersEs._(_root);
}

// Path: home
class _StringsHomeEs implements _StringsHomeEn {
	_StringsHomeEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override late final _StringsHomeFieldsEs fields = _StringsHomeFieldsEs._(_root);
}

// Path: common.daysOfTheWeek
class _StringsCommonDaysOfTheWeekEs implements _StringsCommonDaysOfTheWeekEn {
	_StringsCommonDaysOfTheWeekEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get sunday => 'Domingo';
	@override String get monday => 'Segunda-feira';
	@override String get tuesday => 'Terça-feira';
	@override String get wednesday => 'Quarta-feira';
	@override String get thursday => 'Quinta-feira';
	@override String get friday => 'Sexta-feira';
	@override String get saturday => 'Sábado';
}

// Path: common.messages
class _StringsCommonMessagesEs implements _StringsCommonMessagesEn {
	_StringsCommonMessagesEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get example => 'Example';
}

// Path: common.fields
class _StringsCommonFieldsEs implements _StringsCommonFieldsEn {
	_StringsCommonFieldsEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get example => 'Example';
}

// Path: common.genders
class _StringsCommonGendersEs implements _StringsCommonGendersEn {
	_StringsCommonGendersEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Gênero';
	@override String get hint => 'Selecione o gênero';
	@override String get male => 'Masculino';
	@override String get female => 'Feminino';
}

// Path: home.fields
class _StringsHomeFieldsEs implements _StringsHomeFieldsEn {
	_StringsHomeFieldsEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get example => 'Example';
}

// Path: <root>
class _StringsPt implements _StringsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsPt.build();

	/// Access flat map
	@override dynamic operator[](String key) => _flatMap[key];

	// Internal flat map initialized lazily
	@override late final Map<String, dynamic> _flatMap = _buildFlatMap();

	@override late final _StringsPt _root = this; // ignore: unused_field

	// Translations
	@override String get code => 'pt';
	@override late final _StringsLanguagesPt languages = _StringsLanguagesPt._(_root);
	@override late final _StringsCommonPt common = _StringsCommonPt._(_root);
	@override late final _StringsHomePt home = _StringsHomePt._(_root);
}

// Path: languages
class _StringsLanguagesPt implements _StringsLanguagesEn {
	_StringsLanguagesPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get portuguese => 'Português';
	@override String get english => 'Inglês';
	@override String get spanish => 'Espanhol';
}

// Path: common
class _StringsCommonPt implements _StringsCommonEn {
	_StringsCommonPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override late final _StringsCommonDaysOfTheWeekPt daysOfTheWeek = _StringsCommonDaysOfTheWeekPt._(_root);
	@override late final _StringsCommonMessagesPt messages = _StringsCommonMessagesPt._(_root);
	@override late final _StringsCommonFieldsPt fields = _StringsCommonFieldsPt._(_root);
	@override late final _StringsCommonGendersPt genders = _StringsCommonGendersPt._(_root);
}

// Path: home
class _StringsHomePt implements _StringsHomeEn {
	_StringsHomePt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override late final _StringsHomeFieldsPt fields = _StringsHomeFieldsPt._(_root);
}

// Path: common.daysOfTheWeek
class _StringsCommonDaysOfTheWeekPt implements _StringsCommonDaysOfTheWeekEn {
	_StringsCommonDaysOfTheWeekPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get sunday => 'Domingo';
	@override String get monday => 'Segunda-feira';
	@override String get tuesday => 'Terça-feira';
	@override String get wednesday => 'Quarta-feira';
	@override String get thursday => 'Quinta-feira';
	@override String get friday => 'Sexta-feira';
	@override String get saturday => 'Sábado';
}

// Path: common.messages
class _StringsCommonMessagesPt implements _StringsCommonMessagesEn {
	_StringsCommonMessagesPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get example => 'Example';
}

// Path: common.fields
class _StringsCommonFieldsPt implements _StringsCommonFieldsEn {
	_StringsCommonFieldsPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get example => 'Example';
}

// Path: common.genders
class _StringsCommonGendersPt implements _StringsCommonGendersEn {
	_StringsCommonGendersPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Gênero';
	@override String get hint => 'Selecione o gênero';
	@override String get male => 'Masculino';
	@override String get female => 'Feminino';
}

// Path: home.fields
class _StringsHomeFieldsPt implements _StringsHomeFieldsEn {
	_StringsHomeFieldsPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get example => 'Example';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _StringsEn {
	Map<String, dynamic> _buildFlatMap() {
		return <String, dynamic>{
			'code': 'en',
			'languages.portuguese': 'Portuguese',
			'languages.english': 'English',
			'languages.spanish': 'Spanish',
			'common.daysOfTheWeek.sunday': 'Domingo',
			'common.daysOfTheWeek.monday': 'Segunda-feira',
			'common.daysOfTheWeek.tuesday': 'Terça-feira',
			'common.daysOfTheWeek.wednesday': 'Quarta-feira',
			'common.daysOfTheWeek.thursday': 'Quinta-feira',
			'common.daysOfTheWeek.friday': 'Sexta-feira',
			'common.daysOfTheWeek.saturday': 'Sábado',
			'common.messages.example': 'Example',
			'common.fields.example': 'Example',
			'common.genders.title': 'Gênero',
			'common.genders.hint': 'Selecione o gênero',
			'common.genders.male': 'Masculino',
			'common.genders.female': 'Feminino',
			'home.fields.example': 'Example',
		};
	}
}

extension on _StringsEs {
	Map<String, dynamic> _buildFlatMap() {
		return <String, dynamic>{
			'code': 'en-us',
			'languages.portuguese': 'Português',
			'languages.english': 'Inglês',
			'languages.spanish': 'Espanhol',
			'common.daysOfTheWeek.sunday': 'Domingo',
			'common.daysOfTheWeek.monday': 'Segunda-feira',
			'common.daysOfTheWeek.tuesday': 'Terça-feira',
			'common.daysOfTheWeek.wednesday': 'Quarta-feira',
			'common.daysOfTheWeek.thursday': 'Quinta-feira',
			'common.daysOfTheWeek.friday': 'Sexta-feira',
			'common.daysOfTheWeek.saturday': 'Sábado',
			'common.messages.example': 'Example',
			'common.fields.example': 'Example',
			'common.genders.title': 'Gênero',
			'common.genders.hint': 'Selecione o gênero',
			'common.genders.male': 'Masculino',
			'common.genders.female': 'Feminino',
			'home.fields.example': 'Example',
		};
	}
}

extension on _StringsPt {
	Map<String, dynamic> _buildFlatMap() {
		return <String, dynamic>{
			'code': 'pt',
			'languages.portuguese': 'Português',
			'languages.english': 'Inglês',
			'languages.spanish': 'Espanhol',
			'common.daysOfTheWeek.sunday': 'Domingo',
			'common.daysOfTheWeek.monday': 'Segunda-feira',
			'common.daysOfTheWeek.tuesday': 'Terça-feira',
			'common.daysOfTheWeek.wednesday': 'Quarta-feira',
			'common.daysOfTheWeek.thursday': 'Quinta-feira',
			'common.daysOfTheWeek.friday': 'Sexta-feira',
			'common.daysOfTheWeek.saturday': 'Sábado',
			'common.messages.example': 'Example',
			'common.fields.example': 'Example',
			'common.genders.title': 'Gênero',
			'common.genders.hint': 'Selecione o gênero',
			'common.genders.male': 'Masculino',
			'common.genders.female': 'Feminino',
			'home.fields.example': 'Example',
		};
	}
}
