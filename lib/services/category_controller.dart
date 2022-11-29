import 'package:get/get.dart';
import 'package:pingo/constants/design_emojis.dart';
import 'package:pingo/constants/keywords.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/models/base.dart';
import 'package:pingo/models/category.dart';
import 'package:pingo/models/user.dart';

final all = Category(Keywords.all, 'All', DesignEmojis.all);

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

    var list = <Keyword>[];

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
      final emoji = allKeywords.firstWhere((k) => k.id == keyword.id).emoji;

      final category = Category(keyword.id, keyword.title, emoji);
      categories.add(category);
    }

    return categories;
  }

  List<Keyword> get general {
    final list = <Keyword>[];
    list.addAll(places);

    final events =
        allKeywords.firstWhere((keyword) => keyword.id == Keywords.event);
    list.insert(2, events);

    final products =
        allKeywords.firstWhere((keyword) => keyword.id == Keywords.product);
    list.insert(3, products);

    return list;
  }

  List<Keyword> get places {
    final list = placesKeywords
        .where((keyword) => user.keywords.contains(keyword.id))
        .toList();

    if (user.keywords.contains(Keywords.fastFood)) {
      final fastFood =
          allKeywords.firstWhere((keyword) => keyword.id == Keywords.fastFood);
      list.add(fastFood);
    }

    final fashion =
        allKeywords.firstWhere((keyword) => keyword.id == Keywords.fashion);

    final util =
        allKeywords.firstWhere((keyword) => keyword.id == Keywords.util);

    list.add(fashion);

    list.add(util);

    return list;
  }

  List<Keyword> get events {
    var list = <Keyword>[];

    if (user.keywords.contains(Keywords.children)) {
      final children =
          allKeywords.firstWhere((keyword) => keyword.id == Keywords.children);
      list.add(children);
    }

    if (user.keywords.contains(Keywords.party)) {
      final party =
          allKeywords.firstWhere((keyword) => keyword.id == Keywords.party);
      list.add(party);
    }

    if (user.keywords.contains(Keywords.concert)) {
      final concert =
          allKeywords.firstWhere((keyword) => keyword.id == Keywords.concert);
      list.add(concert);
    }

    list.addAll(
        musics.where((keyword) => user.keywords.contains(keyword.id)).toList());

    final free =
        allKeywords.firstWhere((keyword) => keyword.id == Keywords.free);

    list.insert(1, free);
    final open =
        allKeywords.firstWhere((keyword) => keyword.id == Keywords.open);

    list.insert(2, open);

    return list;
  }

  List<Keyword> get products {
    var list = <Keyword>[];

    if (user.keywords.contains(Keywords.children)) {
      final children = allKeywords.firstWhere((k) => k.id == Keywords.children);
      list.add(children);
    }
    if (user.keywords.contains(Keywords.pet)) {
      final pet =
          allKeywords.firstWhere((keyword) => keyword.id == Keywords.pet);
      list.add(pet);
    }

    if (user.keywords.contains(Keywords.beer)) {
      final beer =
          allKeywords.firstWhere((keyword) => keyword.id == Keywords.beer);
      list.add(beer);
    }

    if (user.keywords.contains(Keywords.drinks) ||
        user.keywords.contains(Keywords.gin)) {
      final drinks =
          allKeywords.firstWhere((keyword) => keyword.id == Keywords.drinks);
      list.add(drinks);
    }

    final promo =
        allKeywords.firstWhere((keyword) => keyword.id == Keywords.promo);

    list.addAll(
        foods.where((keyword) => user.keywords.contains(keyword.id)).toList());

    if (user.keywords.contains(Keywords.skate)) {
      final skate =
          allKeywords.firstWhere((keyword) => keyword.id == Keywords.skate);
      list.add(skate);
    }

    if (user.keywords.contains(Keywords.rollerblades)) {
      final rollerblades = allKeywords
          .firstWhere((keyword) => keyword.id == Keywords.rollerblades);
      list.add(rollerblades);
    }

    if (user.keywords.contains(Keywords.bike)) {
      final bike =
          allKeywords.firstWhere((keyword) => keyword.id == Keywords.bike);
      list.add(bike);
    }

    list.insert(1, promo);

    return list;
  }

  String getEmoji(int keyword) {
    switch (keyword) {
      case Keywords.restaurant:
        return DesignEmojis.restaurant;
      case Keywords.pub:
        return DesignEmojis.pub;
      case Keywords.event:
        return DesignEmojis.eventWoman;
      case Keywords.product:
        return DesignEmojis.product;
      case Keywords.fastFood:
        return DesignEmojis.fastFood;
      case Keywords.shopping:
        return DesignEmojis.shopping;
      case Keywords.fashion:
        return DesignEmojis.shopping;
      case Keywords.theater:
        return DesignEmojis.theater;
      case Keywords.museum:
        return DesignEmojis.museum;
      case Keywords.historical:
        return DesignEmojis.historical;
      case Keywords.util:
        return DesignEmojis.utils;
      case Keywords.children:
        return DesignEmojis.children;
      case Keywords.pet:
        return DesignEmojis.pet;
      case Keywords.concert:
        return DesignEmojis.concert;
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
