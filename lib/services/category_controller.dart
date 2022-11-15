import 'package:get/get.dart';
import 'package:pingo/constants/design_emojis.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/models/base.dart';
import 'package:pingo/models/category.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/models/matchbase.dart';
import 'package:pingo/models/user.dart';

final all = Category(Keyword.all, 'All', DesignEmojis.all);

enum CategoryType { general, places, events, products }

class CategoryController extends GetxController {
  // CATEGORIAS PRINCIPAIS
  // <Restaurantes, Bares>, Eventos, Produtos, <Fast Foods>, Moda, <Teatros>, <Museus>, <Lugares Historicos>, Uteis.

  // CATEGORIAS DE LUGARES
  //// Restaurantes, Cafeterias, (Cafés, Padarias),
  //// Bares, Baladas, Museus, Teatros, Parques, Praças, Espaço Kids, Lugares Historicos, Cinemas,
  //// Centro Cultural, Pratica de Esportes, Livrarias, Exposição Artística

  // CATEGORIAS DE EVENTOS
  //// Gratuitos, ['Kids'], Abertos, Shows, Festas, Festivais,

  // CATEGORIAS DE PRODUTOS
  //// Comidas, Bebidas, Doces, Promocoes, Moda, Saude, Uteis

  // AS CATEGORIAS SERAO POR PALAVRAS-CHAVES (KEYWORD DATA);
  // AS CATEGORIAS SERAO A INTERSECCAO ENTRE AS PALAVRAS CHAVES DO USUARIO E A CATEGORIA DE LUGARES;
  // VAI RECEBER UM KEYWORD DATA E UMA LISTA DE BASE;
  // VAI RETORNAR UMA LISTA FILTRADA DE BASE ONDE POSSUI A PALAVRA-CHAVE.

  final User user = Get.find();

  List<Category> get(CategoryType type) {
    final categories = <Category>[];

    var list = <KeywordData>[];

    if (type == CategoryType.places) {
      list = places;
    } else if (type == CategoryType.events) {
      list = events;
    } else if (type == CategoryType.products) {
      list = products;
    } else {
      list = general;
    }

    /// VERIFICAR DEPOIS
    categories.add(all);

    for (final keyword in list) {
      final emoji = getEmoji(keyword.id);

      final category = Category(keyword.id, keyword.title, emoji);
      categories.add(category);
    }

    return categories;
  }

  List<KeywordData> get general {
    final list = <KeywordData>[];
    list.addAll(places);

    final events =
        allKeywords.firstWhere((keyword) => keyword.id == Keyword.event);
    list.insert(2, events);

    final products =
        allKeywords.firstWhere((keyword) => keyword.id == Keyword.product);
    list.insert(3, products);

    return list;
  }

  List<KeywordData> get places {
    final list = placesKeywords
        .where((keyword) => user.keywords.contains(keyword.id))
        .toList();

    if (user.keywords.contains(Keyword.fastFood)) {
      final fastFood =
          allKeywords.firstWhere((keyword) => keyword.id == Keyword.fastFood);
      list.add(fastFood);
    }

    final fashion =
        allKeywords.firstWhere((keyword) => keyword.id == Keyword.fashion);

    final util =
        allKeywords.firstWhere((keyword) => keyword.id == Keyword.util);

    list.add(fashion);

    list.add(util);

    return list;
  }

  List<KeywordData> get events {
    var list = <KeywordData>[];

    if (user.keywords.contains(Keyword.children)) {
      final children =
          allKeywords.firstWhere((keyword) => keyword.id == Keyword.children);
      list.add(children);
    }

    if (user.keywords.contains(Keyword.party)) {
      final party =
          allKeywords.firstWhere((keyword) => keyword.id == Keyword.party);
      list.add(party);
    }

    if (user.keywords.contains(Keyword.concert)) {
      final concert =
          allKeywords.firstWhere((keyword) => keyword.id == Keyword.concert);
      list.add(concert);
    }

    final free =
        allKeywords.firstWhere((keyword) => keyword.id == Keyword.free);

    list.insert(2, free);
    final open =
        allKeywords.firstWhere((keyword) => keyword.id == Keyword.open);

    list.insert(3, open);

    list.addAll(
        musics.where((keyword) => user.keywords.contains(keyword.id)).toList());

    return list;
  }

  List<KeywordData> get products {
    var list = <KeywordData>[];

    if (user.keywords.contains(Keyword.children)) {
      final children = allKeywords.firstWhere((k) => k.id == Keyword.children);
      list.add(children);
    }
    if (user.keywords.contains(Keyword.pet)) {
      final pet =
          allKeywords.firstWhere((keyword) => keyword.id == Keyword.pet);
      list.add(pet);
    }

    if (user.keywords.contains(Keyword.beer)) {
      final beer =
          allKeywords.firstWhere((keyword) => keyword.id == Keyword.beer);
      list.add(beer);
    }

    if (user.keywords.contains(Keyword.drinks) ||
        user.keywords.contains(Keyword.gin)) {
      final drinks =
          allKeywords.firstWhere((keyword) => keyword.id == Keyword.drinks);
      list.add(drinks);
    }

    final promo =
        allKeywords.firstWhere((keyword) => keyword.id == Keyword.promo);
    list.insert(1, promo);

    list.addAll(
        foods.where((keyword) => user.keywords.contains(keyword.id)).toList());

    if (user.keywords.contains(Keyword.skate)) {
      final skate =
          allKeywords.firstWhere((keyword) => keyword.id == Keyword.skate);
      list.add(skate);
    }

    if (user.keywords.contains(Keyword.rollerblades)) {
      final rollerblades = allKeywords
          .firstWhere((keyword) => keyword.id == Keyword.rollerblades);
      list.add(rollerblades);
    }

    if (user.keywords.contains(Keyword.bike)) {
      final bike =
          allKeywords.firstWhere((keyword) => keyword.id == Keyword.bike);
      list.add(bike);
    }

    return list;
  }

  String getEmoji(int keyword) {
    switch (keyword) {
      case Keyword.restaurant:
        return DesignEmojis.restaurant;
      case Keyword.pub:
        return DesignEmojis.pub;
      case Keyword.event:
        return DesignEmojis.eventWoman;
      case Keyword.product:
        return DesignEmojis.product;
      case Keyword.fastFood:
        return DesignEmojis.fastFood;
      case Keyword.shopping:
        return DesignEmojis.shopping;
      case Keyword.fashion:
        return DesignEmojis.shopping;
      case Keyword.theater:
        return DesignEmojis.theater;
      case Keyword.museum:
        return DesignEmojis.museum;
      case Keyword.historical:
        return DesignEmojis.historical;
      case Keyword.util:
        return DesignEmojis.utils;
      case Keyword.children:
        return DesignEmojis.children;
      case Keyword.pet:
        return DesignEmojis.pet;
      default:
        return DesignEmojis.all;
    }
  }

  bool get showAll => category.value == all;

  var category = all.obs;

  void setCategory(Category v) => category(v);

  List<Base> filterByCategory(List<Base> list) {
    if (category.value == all) return list;
    return list
        .where((base) =>
            base.keywords.any((keyword) => keyword == category.value.id))
        .toList();
  }
}
