import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/models/address.dart';
import 'package:pingo/models/base.dart';
import 'package:pingo/models/rating.dart';
import 'package:pingo/models/user.dart';

class Place extends Base {
  final Address address;
  final String? email;
  final List<int> keywords;
  final int? open;
  final int? close;

  final products = <Product>[];
  final ratings = <Rating>[];

  int? match;

  Place({
    required this.address,
    this.close,
    this.email,
    this.keywords = const [],
    this.open,
    required String name,
    required String description,
    required String createdBy,
    String? image,
  }) : super(
          name: name,
          description: description,
          image: image,
        );

  final GeoPoint currentLocation = Get.find();

  @override
  double get distance {
    return Geolocator.distanceBetween(
      -23.548457045227913, -46.646617959134126,
      // currentLocation.latitude,
      // currentLocation.longitude,
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
        keywords = List.from(document['keywords']),
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

  int compareTo(Place other) {
    // TODO: SUBSTITUIR PELA MAX DISTANCE DO FILTRO
    if (distance <= 1000) {
      if (match == other.match) return distance.compareTo(other.distance);
      return match!.compareTo(other.match!) * -1;
    } else {
      return distance.compareTo(other.distance);
    }
  }
}
