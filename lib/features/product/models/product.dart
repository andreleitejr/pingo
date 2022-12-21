import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pingo/constants/design_images.dart';
import 'package:pingo/constants/keywords.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/models/buyable.dart';
import 'package:pingo/models/image_blurhash.dart';

class Product extends Buyable {
  final String placeId;

  Place? place;

  Product({
    required this.placeId,
    required super.price,
    required super.name,
    required super.keywords,
    super.description,
    super.image,
    super.promotionalPrice,
  });

  Product.fromMap(DocumentSnapshot document)
      : placeId = document['placeId'] as String,
        super.fromMap(document);

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'keywords': keywords,
        'placeId': placeId,
      });
  }
}

List<Product> products = [
  Product(
    image: ImageBlurHash(
      image: DesignImages.fallbackImage,
      blurHash: 'LEHLk~WB2yk8pyo0adR*.7kCMdnj',
    ),
    keywords: [
      Keywords.drinks,
      Keywords.beer,
    ],
    price: 4.90,
    promotionalPrice: 2.90,
    placeId: 'doCcYcFgUV3UXihqipl4',
    name: 'Stella Artois',
    description: 'Stella geladinha no precinho.',
  ),
  Product(
    image: ImageBlurHash(
      image: DesignImages.fallbackImage,
      blurHash: 'LEHLk~WB2yk8pyo0adR*.7kCMdnj',
    ),
    keywords: [
      Keywords.museum,
      Keywords.ticket,
    ],
    price: 14.90,
    promotionalPrice: 9.90,
    placeId: 'We4tknKO5zC4y5OdnGEZ',
    name: 'Ingresso Museu',
    description: 'Museu muito legal.',
  ),
  Product(
    image: ImageBlurHash(
      image: DesignImages.fallbackImage,
      blurHash: 'LEHLk~WB2yk8pyo0adR*.7kCMdnj',
    ),
    keywords: [
      Keywords.pizza,
    ],
    price: 49.90,
    promotionalPrice: 34.90,
    placeId: 'fGZBeqxV1Vyzv2G9pxW1',
    name: 'Pizza',
    description: 'Delicious pizza.',
  ),
  Product(
    image: ImageBlurHash(
      image: DesignImages.fallbackImage,
      blurHash: 'LEHLk~WB2yk8pyo0adR*.7kCMdnj',
    ),
    keywords: [
      Keywords.burger,
    ],
    price: 39.90,
    promotionalPrice: 29.90,
    placeId: 'SFOwXCXpVvUVf73oo2AW',
    name: 'Burger',
    description: 'Delicious burger.',
  ),
  Product(
    image: ImageBlurHash(
      image: DesignImages.fallbackImage,
      blurHash: 'LEHLk~WB2yk8pyo0adR*.7kCMdnj',
    ),
    keywords: [
      Keywords.brazilian,
    ],
    price: 19.90,
    promotionalPrice: 14.90,
    placeId: 'sLWAsprJ5FTr9HZXepxO',
    name: 'Food Plate',
    description: 'Delicious food plate.',
  ),
  Product(
    image: ImageBlurHash(
      image: DesignImages.fallbackImage,
      blurHash: 'LEHLk~WB2yk8pyo0adR*.7kCMdnj',
    ),
    keywords: [
      Keywords.italian,
    ],
    price: 59.90,
    promotionalPrice: 44.90,
    placeId: 'sLWAsprJ5FTr9HZXepxO',
    name: 'Food Plate II',
    description: 'Delicious food plate.',
  ),
  Product(
    image: ImageBlurHash(
      image: DesignImages.fallbackImage,
      blurHash: 'LEHLk~WB2yk8pyo0adR*.7kCMdnj',
    ),
    keywords: [
      Keywords.chinese,
    ],
    price: 29.90,
    promotionalPrice: 20.90,
    placeId: 'SFOwXCXpVvUVf73oo2AW',
    name: 'Yakissoba',
    description: 'Delicious yakissoba.',
  ),
  Product(
    image: ImageBlurHash(
      image: DesignImages.fallbackImage,
      blurHash: 'LEHLk~WB2yk8pyo0adR*.7kCMdnj',
    ),
    keywords: [
      Keywords.skate,
    ],
    price: 79.90,
    promotionalPrice: 49.90,
    placeId: '0aeFWqz3sWMFfIa19g5n',
    name: 'Rodinha de Skate',
    description: 'Rodinha de skate muito bonita.',
  ),
];
