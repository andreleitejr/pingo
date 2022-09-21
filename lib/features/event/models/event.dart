import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/models/buyable.dart';
import 'package:pingo/models/rating.dart';

class Event extends Buyable {
  final String placeId;
  final DateTime start;
  final DateTime end;

  Place? place;
  final ratings = <Rating>[];

  Event({
    required this.placeId,
    required this.start,
    required this.end,
    required super.price,
    required super.name,
    required super.keywords,
    super.description,
    super.image,
    super.promotionalPrice,
  });

  Event.fromMap(DocumentSnapshot document)
      : placeId = document['placeId'] as String,
        start = (document['start'] as Timestamp).toDate(),
        end = (document['end'] as Timestamp).toDate(),
        super.fromMap(document);

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'placeId': placeId,
        'start': start,
        'end': end,
      });
  }
}

List<Event> events = [
  Event(
    image:
        'https://d3ugyf2ht6aenh.cloudfront.net/stores/001/129/410/products/stela-artois-3551-5a863fde4374b45cdd15869272304668-480-0.jpg',
    keywords: [
      Keyword.rock,
      Keyword.concert,
    ],
    price: 50,
    placeId: 'pMsGwBcUydZ9u8XyJEQa',
    name: 'Show de Rock',
    description: 'Show de Rock muito legal',
    start: DateTime.parse('2022-09-22 14:00:04Z'),
    end: DateTime.parse('2022-09-22 22:30:04Z'),
  ),
  Event(
    image:
        'https://blog.biglar.com.br/wp-content/uploads/2021/12/iStock-1310029561.jpg',
    keywords: [
      Keyword.theater,
      Keyword.art,
    ],
    price: 14.90,
    placeId: 'uXULvrwslJ3xRg5FWWCe',
    name: 'Peça de Teatro',
    description: 'Peca de Teatro muito legal na cidade.',
    start: DateTime.parse('2022-09-22 14:00:04Z'),
    end: DateTime.parse('2022-09-22 22:30:04Z'),
  ),
  Event(
    image:
        'https://t2.rg.ltmcdn.com/pt/posts/9/8/3/pizza_calabresa_e_mussarela_4389_600.jpg',
    keywords: [
      Keyword.concert,
      Keyword.rap,
      Keyword.trap,
    ],
    price: 0,
    placeId: '9OPRh6Mhn7o39gu1rRzu',
    name: 'Batalha de Rap',
    description: 'Super batalha de rap muito bacana.',
    start: DateTime.parse('2022-09-22 14:00:04Z'),
    end: DateTime.parse('2022-09-22 22:30:04Z'),
  ),
  Event(
    image:
        'https://www.minervafoods.com/wp-content/uploads/2021/01/burguer-de-picanha-380x484.jpg',
    keywords: [
      Keyword.electronic,
      Keyword.party,
      Keyword.house,
      Keyword.trance,
      Keyword.techno,
    ],
    price: 100,
    placeId: '2UkiDk2woS1JZlXUAYSM',
    name: 'Balada Eletrônica',
    description: 'Balada com música eletrônica muito agitada.',
    start: DateTime.parse('2022-09-22 14:00:04Z'),
    end: DateTime.parse('2022-09-22 22:30:04Z'),
  ),
  Event(
    image:
        'https://www.sabornamesa.com.br/media/k2/items/cache/2db073658ef98ff1d00d15e09c24406a_L.jpg',
    keywords: [
      Keyword.rock,
      Keyword.metal,
      Keyword.concert,
    ],
    price: 0,
    placeId: 'Qsm70lr8LoYR41Tl4xOW',
    name: 'Show de Metal',
    description: 'Show de metal pesado muito legal.',
    start: DateTime.parse('2022-09-22 14:00:04Z'),
    end: DateTime.parse('2022-09-22 22:30:04Z'),
  ),
  Event(
    image:
        'https://www.sabornamesa.com.br/media/k2/items/cache/5031e263a4a258791d6306b2d3d9dbf6_XL.jpg',
    keywords: [
      Keyword.country,
    ],
    price: 59.90,
    placeId: '2UkiDk2woS1JZlXUAYSM',
    name: 'Show de Sertanejo',
    description: 'Show de Sertanejo muito legal.',
    start: DateTime.parse('2022-09-22 14:00:04Z'),
    end: DateTime.parse('2022-09-22 22:30:04Z'),
  ),
  Event(
    image:
        'https://www.ajinomotofoodservice.com.br/uploads/recitas/recitas/yakissoba-480x480-26-07-2019-ud1il.jpg',
    keywords: [
      Keyword.skate,
    ],
    price:10,
    placeId: 'uXULvrwslJ3xRg5FWWCe',
    name: 'Campeonato de Skate',
    description: 'Super campeonato de skate.',
    start: DateTime.parse('2022-09-22 14:00:04Z'),
    end: DateTime.parse('2022-09-22 22:30:04Z'),
  ),
  Event(
    image:
        'https://cdn.awsli.com.br/600x450/591/591154/produto/24370730/ff74214a1f.jpg',
    keywords: [
      Keyword.museum,
      Keyword.art,
      Keyword.exposition,
    ],
    price: 19.90,
    placeId: 'Qsm70lr8LoYR41Tl4xOW',
    name: 'Exposição de Arte',
    description: 'Super exposição de arte com artistas muito legais.',
    start: DateTime.parse('2022-09-22 14:00:04Z'),
    end: DateTime.parse('2022-09-22 22:30:04Z'),
  ),
];
