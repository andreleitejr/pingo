import 'package:pingo/constants/design_emojis.dart';
import 'package:pingo/constants/design_images.dart';
import 'package:pingo/constants/keyword_image.dart';

class KeywordData {
  final String title;
  final String emoji;
  final String image;
  final int id;

  KeywordData(this.title, this.id, this.emoji, this.image);
}

class Keyword {
  static const all = 90000030;
  static const event = 90000;
  static const product = 90001;

  /// TYPES OF PLACES
  static const shopping = 0;
  static const restaurant = 1;
  static const pub = 2;
  static const party = 3;
  static const children = 909309309;
  static const pet = 90930977;
  static const concert = 4;
  static const park = 5;
  static const museum = 6;
  static const square = 7;
  static const cinema = 8;
  static const historical = 9;
  static const theater = 10;
  static const bookstore = 11;
  static const exposition = 12;
  static const festival = 188888882;

  /// TYPES OF FOOD
  static const brazilian = 13;
  static const fastFood = 14;
  static const pizza = 15;
  static const burger = 16;
  static const hotDog = 17;
  static const candy = 18;
  static const donuts = 19;
  static const japanese = 20;
  static const mexican = 21;
  static const chinese = 22;
  static const italian = 23;
  static const thai = 24;
  static const greek = 25;
  static const arabian = 26;
  static const coxinha = 27;
  static const marmita = 28;
  static const pastel = 29;
  static const esfiha = 30;

  /// TYPES OF MUSIC
  static const rock = 31;
  static const pop = 32;
  static const country = 33;
  static const electronic = 34;
  static const funk = 35;
  static const house = 36;
  static const trap = 37;
  static const techno = 38;
  static const rap = 39;
  static const samba = 40;
  static const metal = 41;
  static const pagode = 42;
  static const gospel = 43;
  static const classic = 44;
  static const mpb = 45;
  static const blues = 46;
  static const jazz = 47;
  static const trance = 48;
  static const hardcore = 49;
  static const punk = 50;

  /// MISCELLANEOUS
  static const gym = 51;
  static const beer = 52;
  static const sports = 53;
  static const games = 54;
  static const dance = 55;
  static const anime = 56;
  static const chocolate = 57;
  static const streetArt = 58;
  static const bike = 59;
  static const skate = 60;
  static const rollerblades = 61;
  static const art = 62;
  static const tattoo = 63;
  static const meditation = 64;
  static const soccer = 65;
  static const basketball = 66;
  static const volleyball = 67;
  static const tennis = 68;
  static const ufc = 69;
  static const boxing = 70;
  static const bjj = 71;
  static const thaiBoxing = 72;
  static const gin = 73;
  static const scotch = 74;
  static const drinks = 75;
  static const soda = 76;

  /// SEXUAL ORIENTATION
  static const lgbt = 99;

  /// SEXUAL ORIENTATION
  static const util = 189;
  static const police = 190;
  static const emergency = 191;
  static const hospital = 192;
  static const fireDepartment = 193;

  /// PRODUCTS
  static const ticket = 200;

  static const store = 300;
  static const fashion = 320;
  static const free = 3256450;
  static const open = 32564580;
  static const promo = 325645222;
}

final allKeywords = placesKeywords + foods + musics + miscellaneous + other;

final placesKeywords = <KeywordData>[
  KeywordData(
    'Restaurant',
    Keyword.restaurant,
    DesignEmojis.restaurant,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Pub',
    Keyword.pub,
    DesignEmojis.pub,
    KeywordImage.pub,
  ),
  KeywordData(
    'Party',
    Keyword.party,
    DesignEmojis.eventWoman,
    KeywordImage.party,
  ),
  KeywordData(
    'Concert',
    Keyword.concert,
    DesignEmojis.concert,
    KeywordImage.concert,
  ),
  KeywordData(
    'Children',
    Keyword.children,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Pets',
    Keyword.pet,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Park',
    Keyword.park,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Museum',
    Keyword.museum,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Store',
    Keyword.store,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Square',
    Keyword.square,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Historical',
    Keyword.historical,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Theater',
    Keyword.theater,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Bookstore',
    Keyword.bookstore,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Exposition',
    Keyword.exposition,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
];

final foods = <KeywordData>[
  KeywordData(
    'Brazilian',
    Keyword.brazilian,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Fast Food',
    Keyword.fastFood,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Pizza',
    Keyword.pizza,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Burger',
    Keyword.burger,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Hot Dog',
    Keyword.hotDog,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Candy',
    Keyword.candy,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Donuts',
    Keyword.donuts,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Japanese',
    Keyword.japanese,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Mexican',
    Keyword.mexican,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Chinese',
    Keyword.chinese,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Italian',
    Keyword.italian,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
      'Thai', Keyword.thai, DesignEmojis.fastFood, DesignImages.fallbackImage),
  KeywordData(
    'Greek',
    Keyword.greek,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Arabian',
    Keyword.arabian,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Coxinha',
    Keyword.coxinha,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Marmita',
    Keyword.marmita,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Pastel',
    Keyword.pastel,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Esfiha',
    Keyword.esfiha,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
];

final musics = <KeywordData>[
  KeywordData(
      'Rock', Keyword.rock, DesignEmojis.fastFood, DesignImages.fallbackImage),
  KeywordData(
      'Pop', Keyword.pop, DesignEmojis.fastFood, DesignImages.fallbackImage),
  KeywordData(
    'Country',
    Keyword.country,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Eletronic',
    Keyword.electronic,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
      'Funk', Keyword.funk, DesignEmojis.fastFood, DesignImages.fallbackImage),
  KeywordData(
    'House',
    Keyword.house,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
      'Trap', Keyword.trap, DesignEmojis.fastFood, DesignImages.fallbackImage),
  KeywordData(
    'Techno',
    Keyword.techno,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
      'Rap', Keyword.rap, DesignEmojis.fastFood, DesignImages.fallbackImage),
  KeywordData(
    'Samba',
    Keyword.samba,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Metal',
    Keyword.metal,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Pagode',
    Keyword.pagode,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Gospel',
    Keyword.gospel,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Classic',
    Keyword.classic,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
      'MPB', Keyword.mpb, DesignEmojis.fastFood, DesignImages.fallbackImage),
  KeywordData(
    'Blues',
    Keyword.blues,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
      'Jazz', Keyword.jazz, DesignEmojis.fastFood, DesignImages.fallbackImage),
  KeywordData(
    'Trance',
    Keyword.trance,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Hardcore',
    Keyword.hardcore,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
      'Punk', Keyword.punk, DesignEmojis.fastFood, DesignImages.fallbackImage),
];

final miscellaneous = <KeywordData>[
  KeywordData(
      'LGBT', Keyword.lgbt, DesignEmojis.fastFood, DesignImages.fallbackImage),
  KeywordData(
    'Fashion',
    Keyword.fashion,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
      'Gym', Keyword.gym, DesignEmojis.fastFood, DesignImages.fallbackImage),
  KeywordData(
      'Beer', Keyword.beer, DesignEmojis.fastFood, DesignImages.fallbackImage),
  KeywordData(
    'Sports',
    Keyword.sports,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Games',
    Keyword.games,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Dance',
    Keyword.dance,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Anime',
    Keyword.anime,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Chocolate',
    Keyword.chocolate,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Street Art',
    Keyword.streetArt,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
      'Bike', Keyword.bike, DesignEmojis.fastFood, DesignImages.fallbackImage),
  KeywordData(
    'Skate',
    Keyword.skate,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Rollerblades',
    Keyword.rollerblades,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
      'Art', Keyword.art, DesignEmojis.fastFood, DesignImages.fallbackImage),
  KeywordData(
    'Tattoo',
    Keyword.tattoo,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Meditation',
    Keyword.meditation,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Soccer',
    Keyword.soccer,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Basketball',
    Keyword.basketball,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Volleyball',
    Keyword.volleyball,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Tennis',
    Keyword.tennis,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
      'UFC', Keyword.ufc, DesignEmojis.fastFood, DesignImages.fallbackImage),
  KeywordData(
    'Boxing',
    Keyword.boxing,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Brazilian Jiu Jitsu',
    Keyword.bjj,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Thai Boxing',
    Keyword.thaiBoxing,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
      'Gin', Keyword.gin, DesignEmojis.fastFood, DesignImages.fallbackImage),
  KeywordData(
    'Drinks',
    Keyword.drinks,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
];

final other = [
  KeywordData(
    'Event',
    Keyword.event,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
    'Product',
    Keyword.product,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
  KeywordData(
      'Util', Keyword.util, DesignEmojis.fastFood, DesignImages.fallbackImage),
  KeywordData(
      'Free', Keyword.free, DesignEmojis.fastFood, DesignImages.fallbackImage),
  KeywordData(
      'Open', Keyword.open, DesignEmojis.fastFood, DesignImages.fallbackImage),
  KeywordData(
    'Promo',
    Keyword.promo,
    DesignEmojis.fastFood,
    KeywordImage.restaurant,
  ),
];
