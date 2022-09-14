import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/models/base.dart';
import 'package:pingo/models/rating.dart';

class Product extends Base {
  final double price;
  final List<int> keywords;
  final String placeId;

  Place? place;
  final ratings = <Rating>[];

  Product({
    required this.price,
    this.keywords = const [],
    required this.placeId,
    required String name,
    required String createdBy,
    String? image,
  }) : super(
          name: name,
          createdBy: createdBy,
        );

  Product.fromMap(DocumentSnapshot document)
      : price = document['price'] as double,
        keywords = List.from(document['categories']),
        placeId = document['placeId'] as String,
        super.fromMap(document);

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'price': price,
        'categories': keywords,
        'placeId': placeId,
      });
  }
}

List<Product> products = [
  Product(
    price: 19.9,
    keywords: [],
    name: 'Teste Produto 1',
    placeId: "JJNNtZhXm4v3egLfz7aq",
    createdBy: "LBq1jxC7ZauF91cDEipT",
  ),
  Product(
    price: 29.9,
    keywords: [],
    name: 'Teste Produto 2',
    placeId: "JJNNtZhXm4v3egLfz7aq",
    createdBy: "LBq1jxC7ZauF91cDEipT",
  ),
];
