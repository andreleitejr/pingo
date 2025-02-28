import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pingo/features/post/models/post.dart';
import 'package:pingo/models/image_blurhash.dart';
import 'package:pingo/models/matchbase.dart';
import 'package:pingo/models/pin.dart';
import 'package:pingo/services/current_location.dart';
import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/models/address.dart';

class Place extends MatchBase {
  final Address address;
  final String? email;
  final String? open;
  final String? close;
  final bool verified;

  final products = <Product>[];
  final events = <Event>[];
  final posts = <Post>[];
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
    this.verified = false,
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
        verified = document['verified'] as bool,
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
        'verified': keywords,
      });
  }

  Pin get pin => Pin(
        markerId: name,
        markerDescription: address.line ?? '',
        latitude: address.location.latitude,
        longitude: address.location.longitude,
      );
}
