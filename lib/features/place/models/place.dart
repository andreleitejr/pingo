import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pingo/services/current_location.dart';
import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/models/address.dart';
import 'package:pingo/models/base.dart';
import 'package:pingo/services/blurhash_controller.dart';

class Place extends Base {
  final Address address;
  final String? email;
  final String? open;
  final String? close;

  final products = <Product>[];
  final events = <Event>[];
  final List<ImageBlurHash>? photos;

  Place({
    required this.address,
    this.close,
    this.email,
    this.open,
    this.photos,
    required super.name,
    required super.keywords,
    required super.description,
    super.image,
  });

  final CurrentLocation currentLocation = Get.find();

  @override
  double get distance {
    return Geolocator.distanceBetween(
      currentLocation.currentCoordinates.latitude,
      currentLocation.currentCoordinates.longitude,
      address.location.latitude,
      address.location.longitude,
    );
  }

  // double? time;

  // calculateTime(int speed) => time = distance.km / speed;

  Place.fromMap(DocumentSnapshot document)
      : address = Address.fromJson(document['address'] as Map<String, dynamic>),
        close = document['close'] as String?,
        email = document['email'] as String,
        open = document['open'] as String?,
        photos = (document['photos'] as List<dynamic>)
            .map((e) => ImageBlurHash.fromJson(
                Map<String, dynamic>.from(e as Map<String, dynamic>)))
            .toList(),
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
        'photos': photos?.map((e) => e.toJson()).toList(),
      });
  }
}
