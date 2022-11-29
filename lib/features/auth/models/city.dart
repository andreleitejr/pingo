class Country {
  final int id;
  final String name;
  final String iso3;
  final String iso2;
  final String numericCode;

  final String phoneCode;
  final String capital;
  final String currency;
  final String currencyName;
  final String currencySymbol;
  final String tld;
  final String native;
  final String region;
  final String subRegion;
  final List<TimeZone> timezones;
  final double latitude;
  final double longitude;
  final String emoji;
  final String emojiU;
  final List<State> states;

  Country({
    required this.id,
    required this.name,
    required this.iso3,
    required this.iso2,
    required this.numericCode,
    required this.phoneCode,
    required this.capital,
    required this.currency,
    required this.currencyName,
    required this.currencySymbol,
    required this.tld,
    required this.native,
    required this.region,
    required this.subRegion,
    required this.timezones,
    required this.latitude,
    required this.longitude,
    required this.emoji,
    required this.emojiU,
    required this.states,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json['id'] as int,
        name: json['name'] as String? ?? '',
        iso3: json['iso3'] as String? ?? '',
        iso2: json['iso2'] as String? ?? '',
        numericCode: json['numericCode'] as String? ?? '',
        phoneCode: json['phoneCode'] as String? ?? '',
        capital: json['capital'] as String? ?? '',
        currency: json['currency'] as String? ?? '',
        currencyName: json['currencyName'] as String? ?? '',
        currencySymbol: json['currencySymbol'] as String? ?? '',
        tld: json['tld'] as String? ?? '',
        native: json['native'] as String? ?? '',
        region: json['region'] as String? ?? '',
        subRegion: json['subRegion'] as String? ?? '',
        timezones: (json['timezones'] as List)
            .map((data) => TimeZone.fromJson(data))
            .toList(),
        latitude: double.tryParse(json['latitude'] as String) ?? 0,
        longitude: double.tryParse(json['longitude'] as String) ?? 0,
        emoji: json['emoji'] as String? ?? '',
        emojiU: json['emojiU'] as String? ?? '',
        states: (json['states'] as List)
            .map((data) => State.fromJson(data))
            .toList(),
      );

// Map<String, dynamic> toJson() => {
//       'id': id,
//       'name': name,
//       'iso3': iso3,
//       'iso2': iso2,
//       'numericCode': numericCode,
//       'phoneCode': phoneCode,
//       'capital': capital,
//       'currency': currency,
//       'currencyName': currencyName,
//       'currencySymbol': currencySymbol,
//       'tld': tld,
//       'native': native,
//       'region': region,
//       'subRegion': subRegion,
//       'timezones': timezones,
//       'latitude': latitude,
//       'longitude': longitude,
//       'emoji': emoji,
//       'emojiU': emojiU,
//     };
}

class State {
  final int id;
  final String name;
  final String stateCode;
  final double latitude;
  final double longitude;
  final String? type;
  final List<City> cities;

  State({
    required this.id,
    required this.name,
    required this.stateCode,
    required this.latitude,
    required this.longitude,
    this.type,
    required this.cities,
  });

  factory State.fromJson(Map<String, dynamic> json) => State(
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
}

class City {
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
}

class TimeZone {
  final String zoneName;

  final int gmtOffset;
  final String gmtOffsetName;

  final String abbreviation;
  final String tzName;

  TimeZone({
    required this.zoneName,
    required this.gmtOffset,
    required this.gmtOffsetName,
    required this.abbreviation,
    required this.tzName,
  });

  factory TimeZone.fromJson(Map<String, dynamic> json) => TimeZone(
        zoneName: json['zoneName'] as String? ?? '',
        gmtOffset: json['gmtOffset'] as int,
        gmtOffsetName: json['gmtOffsetName'] as String? ?? '',
        abbreviation: json['abbreviation'] as String? ?? '',
        tzName: json['tzName'] as String? ?? '',
      );
}
