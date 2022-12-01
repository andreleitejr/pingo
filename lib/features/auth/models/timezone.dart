
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