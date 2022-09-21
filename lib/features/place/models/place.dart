import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/models/address.dart';
import 'package:pingo/models/base.dart';
import 'package:pingo/models/rating.dart';

class Place extends Base {
  final Address address;
  final String? email;
  final int? open;
  final int? close;

  final products = <Product>[];
  final events = <Event>[];
  final ratings = <Rating>[];

  Place({
    required this.address,
    this.close,
    this.email,
    this.open,
    required super.name,
    required super.keywords,
    required super.description,
    super.image,
  });

  final GeoPoint currentLocation = Get.find();

  @override
  double get distance {
    return Geolocator.distanceBetween(
      currentLocation.latitude,
      currentLocation.longitude,
      address.location.latitude,
      address.location.longitude,
    );
  }

  // double? time;

  // calculateTime(int speed) => time = distance.km / speed;

  Place.fromMap(DocumentSnapshot document)
      : address = Address.fromJson(document['address'] as Map<String, dynamic>),
        close = document['close'] as int,
        email = document['email'] as String,
        open = document['open'] as int,
        super.fromMap(document);

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'address': address.toJson(),
        'close': close,
        'email': email,
        'keywords': keywords,
        'open': open,
      });
  }
}
