import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pingo/models/matchbase.dart';

class Buyable extends MatchBase {
  final double price;
  final double? promotionalPrice;

  Buyable({
    required this.price,
    this.promotionalPrice,
    required super.name,
    required super.keywords,
    super.description,
    super.image,
  }) : super();

  Buyable.fromMap(DocumentSnapshot document)
      : price = document['price'] as double,
        promotionalPrice = document['promotionalPrice'] as double?,
        super.fromMap(document);

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'price': price,
        'promotionalPrice': promotionalPrice,
      });
  }

  bool get isPromotion => promotionalPrice != null && promotionalPrice! < price;
}
