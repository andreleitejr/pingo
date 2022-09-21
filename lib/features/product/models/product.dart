import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/models/buyable.dart';
import 'package:pingo/models/rating.dart';

class Product extends Buyable {
  final String placeId;

  Place? place;
  final ratings = <Rating>[];

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
    image:
        'https://d3ugyf2ht6aenh.cloudfront.net/stores/001/129/410/products/stela-artois-3551-5a863fde4374b45cdd15869272304668-480-0.jpg',
    keywords: [
      Keyword.beer,
    ],
    price: 4.90,
    promotionalPrice: 2.90,
    placeId: 'pMsGwBcUydZ9u8XyJEQa',
    name: 'Stella Artois',
    description: 'Stella geladinha no precinho.',
  ),
  Product(
    image:
        'https://blog.biglar.com.br/wp-content/uploads/2021/12/iStock-1310029561.jpg',
    keywords: [
      Keyword.gin,
      Keyword.drinks,
    ],
    price: 14.90,
    promotionalPrice: 9.90,
    placeId: 'uXULvrwslJ3xRg5FWWCe',
    name: 'Gin Tonica',
    description: 'Gin Tonica delicioso e na promocao.',
  ),
  Product(
    image:
        'https://t2.rg.ltmcdn.com/pt/posts/9/8/3/pizza_calabresa_e_mussarela_4389_600.jpg',
    keywords: [
      Keyword.pizza,
    ],
    price: 49.90,
    promotionalPrice: 34.90,
    placeId: '9OPRh6Mhn7o39gu1rRzu',
    name: 'Pizza',
    description: 'Delicious pizza.',
  ),
  Product(
    image:
        'https://www.minervafoods.com/wp-content/uploads/2021/01/burguer-de-picanha-380x484.jpg',
    keywords: [
      Keyword.burger,
    ],
    price: 39.90,
    promotionalPrice: 29.90,
    placeId: '2UkiDk2woS1JZlXUAYSM',
    name: 'Burger',
    description: 'Delicious burger.',
  ),
  Product(
    image:
        'https://www.sabornamesa.com.br/media/k2/items/cache/2db073658ef98ff1d00d15e09c24406a_L.jpg',
    keywords: [
      Keyword.mexican,
    ],
    price: 19.90,
    promotionalPrice: 14.90,
    placeId: 'Qsm70lr8LoYR41Tl4xOW',
    name: 'Burrito',
    description: 'Delicious burrito.',
  ),
  Product(
    image:
        'https://www.sabornamesa.com.br/media/k2/items/cache/5031e263a4a258791d6306b2d3d9dbf6_XL.jpg',
    keywords: [
      Keyword.japanese,
    ],
    price: 59.90,
    promotionalPrice: 44.90,
    placeId: '2UkiDk2woS1JZlXUAYSM',
    name: 'Sushi',
    description: 'Delicious sushi.',
  ),
  Product(
    image:
        'https://www.ajinomotofoodservice.com.br/uploads/recitas/recitas/yakissoba-480x480-26-07-2019-ud1il.jpg',
    keywords: [
      Keyword.chinese,
    ],
    price: 29.90,
    promotionalPrice: 20.90,
    placeId: 'uXULvrwslJ3xRg5FWWCe',
    name: 'Yakissoba',
    description: 'Delicious yakissoba.',
  ),
  Product(
    image:
        'https://cdn.awsli.com.br/600x450/591/591154/produto/24370730/ff74214a1f.jpg',
    keywords: [
      Keyword.skate,
    ],
    price: 79.90,
    promotionalPrice: 49.90,
    placeId: 'Qsm70lr8LoYR41Tl4xOW',
    name: 'Rodinha de Skate',
    description: 'Rodinha de skate muito bonita.',
  ),
];
